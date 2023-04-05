//
//  TodoItem.swift
//  ToDoList
//
//  Created by Justin Zack Wei on 2023-04-03.
//

import Foundation
import Blackbird

struct TodoItem: BlackbirdModel{
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var description: String
    @BlackbirdColumn var completed: Bool
}
