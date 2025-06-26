//
//  FeedModels.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

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
}
