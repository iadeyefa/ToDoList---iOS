//
//  Tasks.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 11/22/23.
//

import Foundation

class Tasks: ObservableObject {
    @Published var items = [TaskItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Tasks")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Tasks") {
            if let decodedItems = try?
                JSONDecoder().decode([TaskItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    // Search Bar Filter for Tasks Class
    @Published var searchText: String = ""
    
    var filteredTasks: [TaskItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { item in
                item.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // Sorts the Tasks by chosen filter
    var sortOptions = ["Default", "Date", "Category", "Task Name"]
    @Published var sortedOrder = ""
    
    var taskSorting: [TaskItem] {
        switch sortedOrder {
        case "Date":
            return filteredTasks.sorted {
                $0.firstDate?.compare($1.firstDate ?? Date.now) == ComparisonResult.orderedDescending
            }
            
        case "Category":
            return filteredTasks.sorted {
                $0.category < $1.category
            }
            
        case "Task Name":
            return filteredTasks.sorted {
                $0.name < $1.name
            }
            
        default:
            return filteredTasks
        }
    }
}
