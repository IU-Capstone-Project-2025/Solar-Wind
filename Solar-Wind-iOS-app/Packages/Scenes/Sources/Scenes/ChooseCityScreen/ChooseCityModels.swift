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
            let text: String
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
    
    struct Model {
        var currentPage: Int
        var itemsPerPage: Int
        var totalPages: Int
        var totalItems: Int
        var items: [String]
    }
    
    struct RootViewModel {
        enum Section: Hashable {
            case items([String])
        }
        let sections: [Section]
        let currentItemsCount: Int
    }
    
    typealias Completion = (Result<Model, AppError>) -> Void
}
