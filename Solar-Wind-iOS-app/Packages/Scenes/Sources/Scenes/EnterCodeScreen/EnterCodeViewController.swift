//
//  EnterCodeViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 13.07.2025.
//

import UIKit

final class EnterCodeViewController: UIViewController {
    private lazy var rootView = EnterCodeView()
    var interactor: EnterCodeInteractor?
    var router: EnterCodeRouter?
    
    override func loadView() {
        view = rootView
        hideKeyboardWhenTappedAround()
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next(let code):
                interactor?.request(EnterCode.Next.Request(code: code))
            }
        }
    }
}

extension EnterCodeViewController {
    func present(_ viewModel: EnterCode.Next.ViewModel) {
        router?.toCity()
    }
}
