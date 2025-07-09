//
//  MyProfileInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 04.07.2025.
//

import Foundation

final class MyProfileInteractor: @unchecked Sendable {
    private let presenter: MyProfilePresenter
    private let worker: MyProfileWorker
    
    init(presenter: MyProfilePresenter, worker: MyProfileWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    @MainActor func logout() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            UserDefaults.standard.synchronize()
        }
        presenter.logout()
    }
    
    public func request(_ request: MyProfile.Fetch.Request) {
        worker.fetch() { [weak self] result in
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
