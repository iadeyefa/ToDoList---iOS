//
//  ExpandedView.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 12/8/23.
//

import SwiftUI

struct ExpandedView: View {
    @State var task: TaskItem
    
    @EnvironmentObject var prioritized: PrioritizedTasks
    
    var categorySymbolName: String {
        switch task.category {
        case "Personal":
            return "person.circle"
            
        case "Business":
            return "bag.circle"
            
        case "School":
            return "graduationcap.circle"
            
        default:
            return "person.circle"
        }
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: categorySymbolName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    
                    VStack(alignment: .leading) {
                        Text(task.name)
                            .font(.headline)
                        
                        Text(dateToString(taskDate: task.firstDate ?? Date.now))
                            .foregroundStyle(.secondary)
                        
                    }
                    
                    Spacer()
                    
                    if prioritized.contains(task) {
                        Spacer()
                        
                        Image(systemName: "pin.circle.fill")
                            .foregroundStyle(.red)
                    }
                }
                
                TaskView(task: $task)
            }
        }
        .padding()
    }
    
    func dateToString(taskDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: taskDate)
    }
}

#Preview {
    ExpandedView(task: TaskItem.example)
}


