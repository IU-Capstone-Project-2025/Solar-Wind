//
//  WelcomeModels.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

enum Welcome {
    enum Fetch {
        struct Request {}
        
        struct Response {
            var model: Model
        }

        struct ViewModel {
            var root: RootViewModel
        }
    }
    
    enum Next {
        struct Request {}

        struct Response {}

        struct ViewModel {}
    }
    
    struct Model {
        let logoImageName: String
        let slogan: String
        let buttonTitle: String
    }
    
    struct RootViewModel {
        let logoImageName: String
        let slogan: String
        let buttonTitle: String
    }
    
    typealias fetchCompletion = (Result<Model, Error>) -> Void
}
