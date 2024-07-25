//
//  Task.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 11/21/23.
//

import Foundation

struct TaskItem: Codable, Identifiable {
    let id: String
    var name: String
    var description: String
    var category: String
    var firstDate: Date?
    var repeatNature: Bool
    var repeatFreq: String
    var secondDate: Date?
    var thirdDate: Date?
    var fourthDate: Date?
    var notificationsOn: Bool

    static var example = TaskItem(id: "Buy Groceries", name: "Buy Groceries", description: "Go to Bj's, Food Lion, Walmart, and Target to buy the groceries for the week.", category: "Personal", firstDate: Date(), repeatNature: true, repeatFreq: "Weekly", secondDate: Date(), thirdDate: Date(), fourthDate: Date(), notificationsOn: false)
}
