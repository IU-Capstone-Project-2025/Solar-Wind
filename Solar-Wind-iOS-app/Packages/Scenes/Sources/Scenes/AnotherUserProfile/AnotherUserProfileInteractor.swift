//
//  AnotherUserProfileInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 01.07.2025.
//

import Foundation

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
        let response = AnotherUserProfile.Fetch.Response(model: .init(username: "user", city: "Innopolis", sports: ["Борьба"]))
        DispatchQueue.main.async { self.presenter.present(response) }
    }
}
