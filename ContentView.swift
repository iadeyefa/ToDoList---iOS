//
//  ContentView.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 11/21/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var tasks = Tasks()
    @StateObject var prioritized = PrioritizedTasks()
    
    @State private var addTaskSheet = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    Section {
                        Picker("Sort By", selection: $tasks.sortedOrder) {
                            ForEach(tasks.sortOptions, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section {
                        List {
                            ForEach(tasks.taskSorting) { task in
                                ExpandableView(
                                    thumbnail: ThumbnailView(task: task),
                                    expanded: ExpandedView(task: task)
                                )
                                
                            }
                            .onDelete(perform: removeItem)
                            .shadow(radius: 5)
                        }
                    }
                }
                .navigationTitle("To-Dos")
                .searchable(text: $tasks.searchText)
                
                .toolbar {
                    ToolbarItem {
                        Button("Add Task", systemImage: "plus") {
                            addTaskSheet.toggle()
                        }
                        .padding()
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button("Remove All") {
                            removeAllItems()
                        }
                    }
                }
                
                .sheet(isPresented: $addTaskSheet) {
                    AddTask(tasks: tasks, prioritized: prioritized)
                }
            }
            .environmentObject(prioritized)
        }
    }
    
    
    func removeItem(at offsets: IndexSet) {
        tasks.items.remove(atOffsets: offsets)
    }
    
    func removeAllItems() {
        tasks.items.removeAll()
    }
    
    
    func dateToString(taskDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: taskDate)
    }
}

#Preview {
    ContentView()
}
