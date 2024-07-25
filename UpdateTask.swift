//
//  UpdateTask.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 12/6/23.
//

import SwiftUI

struct UpdateTask: View {
    @Binding var task: TaskItem
    
    @State private var firstDate = Date.now
    @State private var secondDate = Date.now
    @State private var thirdDate = Date.now
    @State private var fourthDate = Date.now

    
    // for prioritization
    @EnvironmentObject var prioritized: PrioritizedTasks
    
    @Environment(\.dismiss) var dismiss
    
    // these array variables cannot be private because they show up in ContentView as well
    let categoryOptions = ["Other", "Personal", "Business", "School"]
    @State private var otherCategory = ""
    
    @State private var repeatNature = false
    let repeatOptions = ["Hourly", "Daily", "Weekly", "Biweekly", "Monthly", "Yearly"]
    @State private var repeatFreq = "Daily"
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Task Name", text: $task.name)
                        
                    TextField("Description (Optional)", text: $task.description)
                        
                    
                    Picker("Category", selection: $task.category) {
                        ForEach(categoryOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                
                    
                    if task.category == "Other" {
                        TextField("Category", text: $otherCategory)
                    }
                }
                
                Section {
                    DatePicker("Time/Date", selection: $firstDate)
                }
                .onAppear {
                    self.firstDate = self.task.firstDate ?? Date.now
                }
                
                Section {
                    Picker("Does this Task Repeat?", selection: $task.repeatNature) {
                        Text("Yes").tag(true)
                        Text("No").tag(false)
                    }
                    
                    if repeatNature == true {
                        Picker("Repeat Frequency", selection: $task.repeatFreq) {
                            ForEach(repeatOptions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section {
                    Button("Save") {
                        task = TaskItem(id: task.id, name: task.name, description: task.description, category: task.category, firstDate: firstDate, repeatNature: repeatNature, repeatFreq: repeatFreq, secondDate: secondDate, thirdDate: thirdDate, fourthDate: fourthDate, notificationsOn: false)
                        
                        dismiss()
                    }
                    .disabled(task.name.isEmpty || (task.category == "Other" && otherCategory.isEmpty))
                }
            }
            .navigationTitle("Update Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


