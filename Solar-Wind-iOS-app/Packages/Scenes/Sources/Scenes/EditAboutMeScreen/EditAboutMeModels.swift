//
//  EditAboutMeModels.swift
//  Scenes
//
//  Created by Даша Николаева on 15.07.2025.
//

import CommonModels

enum EditAboutMe {
    enum Save {
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    enum SearchCity {
        struct Request {
            let word: String
        }
        
        struct Response {
            var model: CityModel?
            var error: AppError?
        }
        
        struct ViewModel {
            var root: CityRootViewModel?
            var error: AppError?
        }
    }
    
    struct CityModel {
        var items: [City]
    }
    
    struct City: Codable, Sendable, Hashable {
        let id: Int
        let name: String
        var isSelected: Bool = false
    }
    
    struct CityRootViewModel {
        enum Section: Hashable {
            case items([City])
        }
        let sections: [Section]
        let currentItemsCount: Int
    }
    
    enum SearchSport {
        struct Request {
            var word: String
        }
        
        struct Response {
            var model: SportModel?
            var error: AppError?
        }
        
        struct ViewModel {
            var root: SportRootViewModel?
            var error: AppError?
        }
    }

    struct SportModel {
        var items: [Category]
    }

    struct Category: Codable, Sendable, Hashable {
        let id: Int
        let name: String
        var isSelected: Bool = false
    }

    struct SportRootViewModel {
        enum Section: Hashable {
            case items([Category])
        }

        let sections: [Section]
        let currentItemsCount: Int
        let selectedCategories: [Category]
    }
    
}
