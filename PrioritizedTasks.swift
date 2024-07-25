//
//  PrioritizedTasks.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 11/21/23.
//

import Foundation

class PrioritizedTasks: ObservableObject {
    @Published var tasks: Set<String>
    private let saveKey = "Prioritized"
    
    init() {
        // loads saved data
        if let data = UserDefaults.standard.data(forKey: "Prioritized") {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                tasks = decoded
                return
            }
        }
        
        tasks = []
    }
    
    func contains(_ task: TaskItem) -> Bool {
        tasks.contains(task.id)
    }
    
    func add(_ task: TaskItem) {
        objectWillChange.send()
        tasks.insert(task.id)
        save()
    }
    
    func remove(_ task: TaskItem) {
        objectWillChange.send()
        tasks.remove(task.id)
        save()
    }
    
    func save() {
        // save new prioritized task
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "Prioritized")
        }
    }
}
