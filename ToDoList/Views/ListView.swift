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
    
    
    @State var newItemDescription: String = ""
    @State var searchText: String = ""
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
                    
                    ListItemsView(filteredOn: searchText)
                    .searchable(text: $searchText)
                    
                }
            }
            .navigationTitle("To do")

        }
    }
   
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
            ListView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
