//
//  FillAboutMeModels.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

import CommonModels

enum FillAboutMe {
    enum Next {
        struct Request {
            let name: String
            let about: String
        }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    typealias FillAboutMeCompletion = (Result<Next.Response, AppError>) -> Void
}
