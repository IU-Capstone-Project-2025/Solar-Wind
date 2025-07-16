//
//  EnterCodeModels.swift
//  Scenes
//
//  Created by Даша Николаева on 13.07.2025.
//

import CommonModels

enum EnterCode {
    enum Next {
        struct Request {
            let code: String
        }
        
        struct Response {
            var model: Model?
            var error: AppError?
        }
        
        struct ViewModel { }
    }
    
    struct Model {
        let id: String
        let token: String
    }
    
    typealias Completion = (Result<Next.Response, AppError>) -> Void
}
