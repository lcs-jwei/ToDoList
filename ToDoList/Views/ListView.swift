//
//  ListView.swift
//  ToDoList
//
//  Created by Justin Zack Wei on 2023-04-03.
//

import SwiftUI
import Blackbird

struct ListView: View {
    
    //MARK: Stored property
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @BlackbirdLiveModels({ db in
        try await TodoItem.read(from: db,
                                sqlWhere: "description LIKE ?", "%\(searchText)%")
    }) var todoItems
    
    @State var newItemDescription: String = ""
    //MARK: Computed Property
    var body: some View {
        NavigationView{
            Group{
                VStack{
                    
                    HStack{
                        TextField("Enter a to-do item", text: $newItemDescription)
                            .padding()
                        Button(action: {
                            Task{
                                try await db!.transaction { core in
                                    try core.query("INSERT INTO TodoItem (description) VALUES (?)", newItemDescription)
                                    
                                }
                                newItemDescription = ""
                            }
                        }, label:{
                            Text("ADD")
                                .font(.caption)
                            
                        })
                        .padding()
                    }
                    
                    List{
                        ForEach(todoItems.results){ currentItem in
                            
                            Label(title: {
                                Text(currentItem.description)
                            }, icon: {
                                if currentItem.completed == true {
                                    Image(systemName: "checkmark.circle")
                                }else{
                                    Image(systemName: "circle")
                                }
                            })
                            .onTapGesture {
                                Task {
                                    try await db!.transaction { core in
                                        try core.query("UPDATE TodoItem SET completed = (?) WHERE id = (?)", !currentItem.completed, currentItem.id)
                                    }
                                }
                            }
                          
                        }
                        .onDelete(perform: removeRows)
                    }
                    .searchable(text: $searchText)
                    
                }
            }
            .navigationTitle("To do")

        }
    }
    //MARK: Functions
    func removeRows(at offsets: IndexSet){
        Task{
            try await db!.transaction{ core in
                var idList = ""
                for offset in offsets{
                    idList += "\(todoItems.results[offset].id),"
                }
                print(idList)
                idList.removeLast()
                print(idList)
                
                try core.query("DELETE FROM TodoItem WHERE id IN (?)",idList)
            }
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
            ListView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
