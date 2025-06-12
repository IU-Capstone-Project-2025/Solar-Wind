//
//  WelcomeProtocols.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

protocol WelcomeBusinessLogic {
    func request(_ request: Welcome.Fetch.Request)
    func request(_ requst: Welcome.Next.Request)
}

protocol WelcomePresentationLogic {
    func present(_ response: Welcome.Fetch.Response)
    func present(_ response: Welcome.Next.Response)
}

protocol WelcomeRoutingLogic {
    func next()
}

protocol WelcomeWorkingLogic {
    func fetch(_ completion: Welcome.fetchCompletion)
}

@MainActor
protocol WelcomeDisplayLogic {
    func display(_ viewModel: Welcome.Fetch.ViewModel)
    func display(_ viewModel: Welcome.Next.ViewModel)
}
