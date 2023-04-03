//
//  ListView.swift
//  ToDoList
//
//  Created by Justin Zack Wei on 2023-04-03.
//

import SwiftUI

struct ListView: View {
    
    //MARK: Stored property
    @State var todoItem : [TodoItem] = existingTodoItems
    
    @State var newItemDescription: String = ""
    //MARK: Computed Property
    var body: some View {
        NavigationView{
            
            VStack{
                
                HStack{
                    TextField("Enter a to-do item", text: Binding.constant(""))
                        .padding()
                    Button(action: {
                        
                    }, label:{
                        Text("ADD")
                            .font(.caption)
                            
                    })
                    .padding()
                }
                
                List{
                    HStack{
                        Image(systemName: "circle")
                            .foregroundColor(.blue)
                        Text("Prepare for Chemistry test")
                    }
                    HStack{
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.blue)
                        Text("Do computer science homework")
                    }
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
