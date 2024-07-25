//
//  Event.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 12/6/23.
//

import Foundation

struct Event: Identifiable {
    enum EventType: String, Identifiable, CaseIterable {
        case work, home, social, sport, unspecified
        
        var id: String {
            self.rawValue
        }
        
        var icon: String {
            switch self {
            case .work:
                return "banknote"
            case .home:
                return "house"
            case .social:
                return "party.popper"
            case .sport:
                return "soccerball"
            case .unspecified:
                return "pin"
            }
        }
    }
}
