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
        worker.fetch(id: userId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.presenter.present(user) }
            case .failure(let error):
                print(error)
            }
        }
//        let response = AnotherUserProfile.Fetch.Response(model: .init(username: "user", city: "Innopolis", sports: ["Борьба"], about: "akjfhb awkefjhb akjwehbf akjwhebfwqe awkejhfdb qwjkehrgb ckwjehb qwefjhbqw kjqwehfb", days: [0, 1, 5]))
//        DispatchQueue.main.async { self.presenter.present(response) }
    }
}
