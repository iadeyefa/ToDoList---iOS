//
//  AddTask.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 11/21/23.
//

import SwiftUI
import MapKit

struct AddTask: View {
    @State private var name = ""
    @State private var description = "" //allow to stay within screen
    @State private var category = ""
    @State private var firstDate = Date.now
    @State private var secondDate = Date.now
    @State private var thirdDate = Date.now
    @State private var fourthDate = Date.now
    
    @ObservedObject var tasks: Tasks
    @ObservedObject var prioritized: PrioritizedTasks
    
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
                    TextField("Task Name", text: $name)
                    TextField("Description (Optional)", text: $description)
                    
                    Picker("Category", selection: $category) {
                        ForEach(categoryOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    
                    if category == "Other" {
                        TextField("Category", text: $otherCategory)
                    }
                }
                
                Section {
                    DatePicker("Time/Date", selection: $firstDate)
                        .datePickerStyle(.graphical)
                }
                
                Section {
                    Picker("Does this Task Repeat?", selection: $repeatNature) {
                        Text("Yes").tag(true)
                        Text("No").tag(false)
                    }
                    
                    if repeatNature == true {
                        Picker("Repeat Frequency", selection: $repeatFreq) {
                            ForEach(repeatOptions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section {
                    Button("Save") {
                        let task = TaskItem(id: name, name: name, description: description, category: category, firstDate: firstDate, repeatNature: repeatNature, repeatFreq: repeatFreq, secondDate: secondDate, thirdDate: thirdDate, fourthDate: fourthDate, notificationsOn: false)
                        
                        tasks.items.append(task)
                        dismiss()
                    }
                    .disabled(name.isEmpty || (category == "Other" && otherCategory.isEmpty))
                }
            }
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddTask(tasks: Tasks(), prioritized: PrioritizedTasks())
}
