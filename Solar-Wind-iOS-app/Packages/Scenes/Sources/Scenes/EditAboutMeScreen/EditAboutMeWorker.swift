//
//  EditAboutMeWorker.swift
//  Scenes
//
//  Created by Даша Николаева on 15.07.2025.
//

import Core
import Foundation

final class EditAboutMeWorker {
    func save(completion: FillAboutMe.FillAboutMeCompletion?) {
        let request = EditAboutMeRequest(userDefaults: UserDefaults.standard)
        
        APIClient.shared.send(request) { result in
            switch result {
            case .success(let response):
                completion?(.success(FillAboutMe.Next.Response()))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func findCity(word: String, completion: @escaping ChooseCity.Completion) {
        let request = CitySearchRequest(word: word)
        
        APIClient.shared.send(request) { result in
            let mappedResult = result.map { cities in
                cities.map { ChooseCity.City(id: $0.id, name: $0.name) }
            }.map { ChooseCity.Model(items: $0) }
            
            DispatchQueue.main.async {
                completion(mappedResult)
            }
        }
    }
    
    func findSport(word: String, completion: @escaping ChooseCategory.Completion) {
        let request = ChooseCategorySearchRequest(word: word)
        APIClient.shared.send(request) { result in
            let mappedResult = result.map { categories in
                categories.map { ChooseCategory.Category(id: $0.id, name: $0.name) }
            }.map { ChooseCategory.Model(items: $0) }
            DispatchQueue.main.async {
                completion(mappedResult)
            }
        }
    }
}
