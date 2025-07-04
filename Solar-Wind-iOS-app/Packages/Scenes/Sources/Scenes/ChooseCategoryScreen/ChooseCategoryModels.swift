//
//  ChooseCategoryModels.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

import CommonModels

enum ChooseCategory {
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
        var items: [Category]
    }

    struct Category: Codable, Sendable, Hashable {
        let id: Int
        let name: String
    }

    struct RootViewModel {
        enum Section: Hashable {
            case items([Category])
        }

        let sections: [Section]
        let currentItemsCount: Int
        let selectedCategories: [Category]
    }


    typealias Completion = (Result<Model, AppError>) -> Void
}
