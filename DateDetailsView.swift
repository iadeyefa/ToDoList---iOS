//
//  DateDetailsView.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 12/4/23.
//

import SwiftUI

struct DateDetailsView: View {
    let task: TaskItem
    
    /*
    var secondDate: Date {
        switch task.repeatFreq {
        case "Hourly":
            return task.firstDate.addingTimeInterval(3600)
        case "Daily":
            return task.firstDate.addingTimeInterval(86400)
        case "Weekly":
            return task.firstDate.addingTimeInterval(604800)
        case "Biweekly":
            return task.firstDate.addingTimeInterval(1209600)
        case "Monthly":
            return task.firstDate.addingTimeInterval(2419200)
        case "Yearly":
            return task.firstDate.addingTimeInterval(31536000)
        default:
            return task.firstDate
        }
    }
    
    var thirdDate: Date {
        switch task.repeatFreq {
        case "Hourly":
            return secondDate.addingTimeInterval(3600)
        case "Daily":
            return secondDate.addingTimeInterval(86400)
        case "Weekly":
            return secondDate.addingTimeInterval(604800)
        case "Biweekly":
            return secondDate.addingTimeInterval(1209600)
        case "Monthly":
            return secondDate.addingTimeInterval(2419200)
        case "Yearly":
            return secondDate.addingTimeInterval(31536000)
        default:
            return task.firstDate
        }
    }
    
    var fourthDate: Date {
        switch task.repeatFreq {
        case "Hourly":
            return thirdDate.addingTimeInterval(3600)
        case "Daily":
            return thirdDate.addingTimeInterval(86400)
        case "Weekly":
            return thirdDate.addingTimeInterval(604800)
        case "Biweekly":
            return thirdDate.addingTimeInterval(1209600)
        case "Monthly":
            return thirdDate.addingTimeInterval(2419200)
        case "Yearly":
            return thirdDate.addingTimeInterval(31536000)
        default:
            return task.firstDate
        }
    }
    
    var fifthDate: Date {
        switch task.repeatFreq {
        case "Hourly":
            return fourthDate.addingTimeInterval(3600)
        case "Daily":
            return fourthDate.addingTimeInterval(86400)
        case "Weekly":
            return fourthDate.addingTimeInterval(604800)
        case "Biweekly":
            return fourthDate.addingTimeInterval(1209600)
        case "Monthly":
            return fourthDate.addingTimeInterval(2419200)
        case "Yearly":
            return fourthDate.addingTimeInterval(31536000)
        default:
            return task.firstDate
        }
    }
    
    var sixthDate: Date {
        switch task.repeatFreq {
        case "Hourly":
            return fifthDate.addingTimeInterval(3600)
        case "Daily":
            return fifthDate.addingTimeInterval(86400)
        case "Weekly":
            return fifthDate.addingTimeInterval(604800)
        case "Biweekly":
            return fifthDate.addingTimeInterval(1209600)
        case "Monthly":
            return fifthDate.addingTimeInterval(2419200)
        case "Yearly":
            return fifthDate.addingTimeInterval(31536000)
        default:
            return task.firstDate
        }
    }
    
    var seventhDate: Date {
        switch task.repeatFreq {
        case "Hourly":
            return sixthDate.addingTimeInterval(3600)
        case "Daily":
            return sixthDate.addingTimeInterval(86400)
        case "Weekly":
            return sixthDate.addingTimeInterval(604800)
        case "Biweekly":
            return sixthDate.addingTimeInterval(1209600)
        case "Monthly":
            return sixthDate.addingTimeInterval(2419200)
        case "Yearly":
            return sixthDate.addingTimeInterval(31536000)
        default:
            return task.firstDate
        }
    }
    */
    
    var body: some View {
        Group {
            VStack {
                Text("Date")
                    .font(.caption.bold())
                
                Text(dateToString(date: task.firstDate ?? Date.now))
                    .font(.callout)
            }
            
            VStack {
                Text("Repeats")
                    .font(.caption.bold())
                
                Text(task.repeatFreq)
                    .font(.callout)
            }
                
                /*
                if task.repeatNature == true {
                    Text(dateToString(date: secondDate))
                        .font(.title2)
                        .padding()
                    
                    Text(dateToString(date: thirdDate))
                        .font(.title3)
                        .padding()
                    
                    Text(dateToString(date: fourthDate))
                        .font(.callout)
                        .padding()
                    
                    Text(dateToString(date: fifthDate))
                        .font(.subheadline)
                        .padding()
                    
                    Text(dateToString(date: sixthDate))
                        .font(.footnote)
                        .padding()
                    
                    Text(dateToString(date: seventhDate))
                        .font(.caption)
                        .padding()
                }
                */
            
        }
        .padding()
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        switch task.repeatFreq {
        case "Hourly":
            dateFormatter.dateFormat = "HH:mm"
            
        case "Daily", "Weekly", "Biweekly", "Monthly":
            dateFormatter.dateFormat = "MMM d"
            
        case "Yearly":
            dateFormatter.dateFormat = "MM/dd/y"
            
        default:
            dateFormatter.dateStyle = .short
        }
        
        
        return dateFormatter.string(from: date)
    }
}

#Preview {
    DateDetailsView(task: TaskItem.example)
}
