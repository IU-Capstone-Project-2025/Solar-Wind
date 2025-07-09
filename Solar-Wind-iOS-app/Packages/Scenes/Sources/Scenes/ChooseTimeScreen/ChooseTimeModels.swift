//
//  ChooseTimeModels.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

enum ChooseTime {
    enum Next {
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    enum Back {
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    enum Select {
        struct Request {
            let dayId: Int
        }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    enum Weekday: Int, CaseIterable {
        case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday

        var title: String {
            switch self {
            case .monday: return "Monday"
            case .tuesday: return "Tuesday"
            case .wednesday: return "Wednesday"
            case .thursday: return "Thursday"
            case .friday: return "Friday"
            case .saturday: return "Saturday"
            case .sunday: return "Sunday"
            }
        }
    }
}
