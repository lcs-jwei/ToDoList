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
    @BlackbirdLiveModels({db in
        try await TodoItem.read(from: db)
    }) var todoItems
    
    @State var newItemDescription: String = ""
    //MARK: Computed Property
    var body: some View {
        NavigationView{
            
            VStack{
                
                HStack{
                    TextField("Enter a to-do item", text: $newItemDescription)
                        .padding()
                    Button(action: {
                    //    let lastId = TodoItem.last!.id
                      //
                        //let newId = lastId + 1
                        
                      //  let newTodoItem = TodoItem(id: newId, description: newItemDescription, completed: false)
                        
                        //todoItem.append(newTodoItem)
                        
                        //newItemDescription = ""
                    }, label:{
                        Text("ADD")
                            .font(.caption)
                            
                    })
                    .padding()
                }
                
                List(todoItems.results){ currentItem in
                    
                    Label(title: {
                        Text(currentItem.description)
                    }, icon: {
                        if currentItem.completed == true {
                            Image(systemName: "checkmark.circle")
                        }else{
                            Image(systemName: "circle")
                        }
                    })
                    
                }
                
            }
            
        }
        .navigationTitle("To do")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
        }
    }
}
