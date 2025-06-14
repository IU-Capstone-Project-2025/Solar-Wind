//
//  WelcomeInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

import Core

final class WelcomeInteractor: WelcomeBusinessLogic {
    func request(_ request: Welcome.Fetch.Request) {
        
    }
    
    func request(_ requst: Welcome.Next.Request) {
        APIClient.shared.send(TestRequest()) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        presenter.present(Welcome.Next.Response())
    }
    
    private var presenter: WelcomePresentationLogic
    private var worker: WelcomeWorkingLogic
    
    init(presenter: WelcomePresentationLogic, worker: WelcomeWorkingLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}
