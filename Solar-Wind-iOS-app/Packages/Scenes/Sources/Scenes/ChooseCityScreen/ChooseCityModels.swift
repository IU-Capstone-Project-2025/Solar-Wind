//
//  ChooseCityModels.swift
//  Scenes
//
//  Created by Даша Николаева on 19.06.2025.
//

import CommonModels

enum ChooseCity {
    enum Fetch {
        struct Request { }
        
        struct Response {
            var model: Model?
            var error: AppError?
        }
        
        struct ViewModel {
            var root: RootViewModel
            var error: AppError?
        }
    }
    
    enum Search {
        struct Request {
            let word: String
        }

        struct Response {
            var model: Model?
            var error: AppError?
        }

        struct ViewModel {
            var root: RootViewModel?
            var error: AppError?
        }
    }
    
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
    
    enum Add {
        struct Request {}

        struct Response {
            var model: Model?
            var error: AppError?
        }

        struct ViewModel {
            var root: RootViewModel?
            var error: AppError?
        }
    }
    
    struct Model {
        var items: [City]
    }
    
    struct City: Codable, Sendable, Hashable {
        let id: Int
        let name: String
        var isSelected: Bool = false
    }
    
    struct RootViewModel {
        enum Section: Hashable {
            case items([City])
        }
        let sections: [Section]
        let currentItemsCount: Int
    }
    
    typealias Completion = (Result<Model, AppError>) -> Void
}
