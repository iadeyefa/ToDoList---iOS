//
//  TaskView.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 11/21/23.
//

import SwiftUI
import UserNotifications


struct TaskView: View {
    @Binding var task: TaskItem
    
    // for prioritization
    @EnvironmentObject var prioritized: PrioritizedTasks
    
    // for Calendar Button
    @State private var showEventEditView = false
    
    // for Edit Button
    @State private var showUpdateSheet = false
    
    // for regular UI
    @State var name = ""
    @State var description = "" //allow to stay within screen
    @State var category = ""
    @State var firstDate = Date.now
    
    // these array variables cannot be private because they show up in ContentView as well
    let categoryOptions = ["Other", "Personal", "Business", "School"]
    @State var otherCategory = ""
    
    @State var repeatNature = false
    let repeatOptions = ["Hourly", "Daily", "Weekly", "Biweekly", "Monthly", "Yearly"]
    @State var repeatFreq = "Daily"
    
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    var categoryBackground: Color {
        switch task.category {
        case "Personal":
            return .red
        case "Business":
            return .green
        case "School":
            return .blue
        default:
            return .red
        }
    }
    
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                Spacer()
                
                VStack {
                    VStack {
                        DateDetailsView(task: task)
                    }
                    .padding()
                    .background(.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    .dynamicTypeSize(.xxLarge)
                    
                    Spacer ()
                    
                    Button("Edit") {
                        showUpdateSheet.toggle()
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
                
                Spacer()
                
                VStack {
                    Text("\(task.category) Task")
                        .padding()
                        .background(categoryBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .font(.title3).bold()
                        .foregroundStyle(.black)
                    
                    
                    Spacer()
                    
                    
                    Button {
                        addNotification(for: task)
                    } label: {
                        HStack {
                            Text("Notify")
                                .font(.callout)
                            Image(systemName: "bell")
                                .foregroundStyle(.black)
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .bold()
                    .border(.secondary, width: 5)
                    .buttonBorderShape(.capsule)
                    
                    
                    
                    Spacer()
                    
                    
                    Button {
                        // Add to Calendar
                        showEventEditView.toggle()
                    } label: {
                        HStack {
                            Text("Calendar")
                                .font(.callout)
                            Image(systemName: "calendar.badge.plus")
                                .foregroundStyle(.black)
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .bold()
                    .border(.secondary, width: 5)
                    .buttonBorderShape(.capsule)
                    
                    
                    Spacer()
                    
                    
                    Button {
                        if prioritized.contains(task) {
                            prioritized.remove(task)
                        } else {
                            prioritized.add(task)
                        }
                    } label: {
                        HStack {
                            Text(prioritized.contains(task) ? "Remove" : "Prioritize")
                                .font(.callout)
                            Image(systemName: "pin")
                                .foregroundStyle(.black)
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .bold()
                    .border(.secondary, width: 5)
                    
                    
                    Spacer()
                }
                .background(categoryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Spacer()
            }
            
            Text(task.description)
        }
        .sheet(isPresented: $showUpdateSheet) {
            UpdateTask(task: $task)
        }
        
        .sheet(isPresented: $showEventEditView) {
            EventEditViewController(task: $task)
        }
        
        .environmentObject(PrioritizedTasks())
    }
    
    
    func datetoInt(taskDate: Date) -> Int {
        guard let timeInterval = task.firstDate?.timeIntervalSince1970 ?? nil else { return Int(Date.now.timeIntervalSince1970) }
        
        let dateInt = Int(timeInterval)
        return dateInt
    }
    
    
    
    func datesYear(taskDate: Date) -> Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: taskDate)
        
        return year
    }
    
    func datesMonth(taskDate: Date) -> Int {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: taskDate)
        
        return month
    }
    
    func datesDay(taskDate: Date) -> Int {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: taskDate)
        
        return day
    }
    
    func datesHour(taskDate: Date) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: taskDate)
        
        return hour
    }
    
    func datesMinute(taskDate: Date) -> Int {
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: taskDate)
        
        return minute
    }
    
    
    // add notis for task
    func addNotification(for task: TaskItem) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = task.name
            content.subtitle = task.description
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = datesHour(taskDate: task.firstDate ?? Date.now)
            dateComponents.minute = datesMinute(taskDate: task.firstDate ?? Date.now)
            
            // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("A problem occured! Please try again.")
                    }
                }
            }
        }
    }
}
    


