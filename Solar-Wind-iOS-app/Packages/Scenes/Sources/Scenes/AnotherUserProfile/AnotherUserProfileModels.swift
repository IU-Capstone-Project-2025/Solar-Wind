//
//  AnotherUserProfileModels.swift
//  Scenes
//
//  Created by Даша Николаева on 01.07.2025.
//

import CommonModels

enum AnotherUserProfile {
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
    
    enum Back {
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
    }

    struct Model {
        let username: String
        let city: String
        let sports: [String]
        let about: String
        let days: [Int]
    }
    
    struct RootViewModel {
        let username: String
        let city: String
        let sports: [String]
        let about: String
        let days: [String]
    }
    
    typealias AnotherUserProfileCompletion = (Result<Fetch.Response, AppError>) -> Void
}
