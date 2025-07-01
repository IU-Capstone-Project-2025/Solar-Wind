//
//  FeedModels.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import CommonModels

enum Feed {
    struct RootViewModel {
        enum Section: Hashable {
            case items([User])
        }
        let sections: [Section]
        let currentItemsCount: Int
        
        struct User: Hashable {
            let id: Int
            let name: String
            let city: String
            let tags: [String]
            let description: String
        }
    }
    
    enum Select {
        struct Request { let userId: Int }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    enum Fetch {
        struct Request { }
        
        struct Response { }
        
        struct ViewModel {
            var root: RootViewModel?
            var error: AppError?
        }
    }
}
