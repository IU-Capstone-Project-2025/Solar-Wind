//
//  ChooseCityWorker.swift
//  Scenes
//
//  Created by Даша Николаева on 19.06.2025.
//

import Core
import CommonModels
import Foundation

final class ChooseCityWorker {
    private let apiClient: APIClient
    private let callbackQueue: DispatchQueue
    
    init(apiClient: APIClient = .shared,
         callbackQueue: DispatchQueue = .main) {
        self.apiClient = apiClient
        self.callbackQueue = callbackQueue
    }
    
    func search(
        page: Int,
        size: Int,
        text: String,
        completion: @escaping ChooseCity.Completion
    ) {
        
        let request = CityRequest(page: page, size: size, searchText: text)
        
        apiClient.send(request) { [callbackQueue] result in
            let mappedResult = result.map { cities in
                cities.map { ChooseCity.City(id: $0.id, name: $0.name) }
            }.map { ChooseCity.Model(items: $0) }
            
            callbackQueue.async {
                completion(mappedResult)
            }
        }
    }
}
