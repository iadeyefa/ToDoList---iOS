//
//  EventEditViewController.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 12/7/23.
//

import Foundation
import SwiftUI
import EventKitUI
import EventKit

struct EventEditViewController: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    typealias UIViewControllerType = EKEventEditViewController
    
    @Binding var task: TaskItem
    
    private let store = EKEventStore()
    
    private var event: EKEvent {
        let event = EKEvent(eventStore: store)
        event.title = task.name
        if let startDate = task.firstDate, let endDate = task.firstDate {
            let startDateComponents = DateComponents(year: datesYear(taskDate: startDate),
                                                     month: datesMonth(taskDate: startDate),
                                                     day: datesDay(taskDate: startDate),
                                                     hour: datesHour(taskDate: startDate),
                                                     minute: datesMinute(taskDate: startDate))
            event.startDate = Calendar.current.date(from: startDateComponents)!
            
            let endDateComponents = DateComponents(year: datesYear(taskDate: endDate),
                                                     month: datesMonth(taskDate: endDate),
                                                     day: datesDay(taskDate: endDate),
                                                     hour: datesHour(taskDate: endDate),
                                                     minute: datesMinute(taskDate: endDate))
            event.endDate = Calendar.current.date(from: endDateComponents)!
            
            event.notes = task.description
        }
        
        return event
    }
    
    
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let eventEditViewController = EKEventEditViewController()
        eventEditViewController.event = event
        eventEditViewController.eventStore = store
        
        eventEditViewController.editViewDelegate = context.coordinator as? any EKEventEditViewDelegate
        return eventEditViewController
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, EKEventViewDelegate {
        var parent: EventEditViewController
        
        init(_ controller: EventEditViewController) {
            self.parent = controller
        }
         
        func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
            parent.presentationMode.wrappedValue.dismiss()
        }
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
}
