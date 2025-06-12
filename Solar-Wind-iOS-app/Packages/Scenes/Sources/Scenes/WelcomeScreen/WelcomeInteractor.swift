//
//  WelcomeInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

final class WelcomeInteractor: WelcomeBusinessLogic {
    func request(_ request: Welcome.Fetch.Request) {
        
    }
    
    func request(_ requst: Welcome.Next.Request) {
        
    }
    
    private var presenter: WelcomePresentationLogic
    private var worker: WelcomeWorkingLogic
    
    init(presenter: WelcomePresentationLogic, worker: WelcomeWorkingLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}
