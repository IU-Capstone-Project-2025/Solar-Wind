//
//  WelcomeViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

import UIKit

final class WelcomeViewController: UIViewController {
    var interactor: WelcomeBusinessLogic?
    var router: WelcomeRoutingLogic?
    
    private lazy var rootView = WelcomeView()
    
    override func loadView() {
        view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                self.interactor?.request(Welcome.Next.Request())
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.request(Welcome.Fetch.Request())
    }
}

extension WelcomeViewController: WelcomeDisplayLogic {
    func display(_ viewModel: Welcome.Fetch.ViewModel) {
        rootView.viewModel = viewModel.root
    }
    
    func display(_ viewModel: Welcome.Next.ViewModel) {
        router?.next()
    }
    
    
}
