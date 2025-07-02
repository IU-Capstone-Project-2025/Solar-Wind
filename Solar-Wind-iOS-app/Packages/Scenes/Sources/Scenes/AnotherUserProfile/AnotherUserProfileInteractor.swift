//
//  AnotherUserProfileInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 01.07.2025.
//

import Foundation
import Core

final class AnotherUserProfileInteractor: @unchecked Sendable {
    private let presenter: AnotherUserProfilePresenter
    private let worker: AnotherUserProfileWorker
    private let userId: Int
    
    public init(presenter: AnotherUserProfilePresenter, worker: AnotherUserProfileWorker, userId: Int) {
        self.presenter = presenter
        self.worker = worker
        self.userId = userId
    }
    
    public func request(_ request: AnotherUserProfile.Fetch.Request) {
        let request = ProfileRequest(id: userId)
        APIClient.shared.send(request) { result in
            switch result {
            case .success(let user):
//                let mappedResult = AnotherUserProfile.Fetch.Response(model: .init(username: <#T##String#>, city: <#T##String#>, sports: <#T##[String]#>, about: <#T##String#>, days: <#T##[Int]#>))
//                DispatchQueue.main.async { self.presenter.present(mappedResult) }
                return
            case .failure(let error):
                print(error)
            }
        }
//        let response = AnotherUserProfile.Fetch.Response(model: .init(username: "user", city: "Innopolis", sports: ["Борьба"], about: "akjfhb awkefjhb akjwehbf akjwhebfwqe awkejhfdb qwjkehrgb ckwjehb qwefjhbqw kjqwehfb", days: [0, 1, 5]))
//        DispatchQueue.main.async { self.presenter.present(response) }
    }
}
