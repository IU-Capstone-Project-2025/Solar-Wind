//
//  ChooseCategoryWorker.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

import Core
import CommonModels
import Foundation

final class ChooseCategoryWorker {
    private let apiClient: APIClient
    private let callbackQueue: DispatchQueue

    init(apiClient: APIClient = .shared,
         callbackQueue: DispatchQueue = .main) {
        self.apiClient = apiClient
        self.callbackQueue = callbackQueue
    }

    func fetch(
        page: Int,
        size: Int,
        completion: @escaping ChooseCategory.Completion
    ) {
        let request = CategoryRequest(page: page, size: size)
        apiClient.send(request) { [callbackQueue] result in
            let mappedResult = result.map { categories in
                categories.map { ChooseCategory.Category(id: $0.id, name: $0.name) }
            }.map { ChooseCategory.Model(items: $0) }
            callbackQueue.async {
                completion(mappedResult)
            }
        }
    }
    
    func find(word: String, completion: @escaping ChooseCategory.Completion) {
        let request = ChooseCategorySearchRequest(word: word)
        apiClient.send(request) { [callbackQueue] result in
            let mappedResult = result.map { categories in
                categories.map { ChooseCategory.Category(id: $0.id, name: $0.name) }
            }.map { ChooseCategory.Model(items: $0) }
            callbackQueue.async {
                completion(mappedResult)
            }
        }
    }
}
