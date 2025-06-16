//
//  WelcomePresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

final class WelcomePresenter: WelcomePresentationLogic {
    var router: WelcomeRoutingLogic?
    
    func present(_ response: Welcome.Fetch.Response) {
    
    }
    
    func present(_ response: Welcome.Next.Response) {
        router?.next()
    }
}
