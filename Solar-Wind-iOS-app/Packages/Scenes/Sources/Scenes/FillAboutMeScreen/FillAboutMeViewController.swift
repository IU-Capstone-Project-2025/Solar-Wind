//
//  FillAboutMeViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

import UIKit
import Core

final class FillAboutMeViewController: UIViewController {
    var router: FillAboutMeRouter?
    var interactor: FillAboutMeInteractor?

    private lazy var rootView = FillAboutMeView()

    override func loadView() {
        view = rootView
        hideKeyboardWhenTappedAround()

        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                self.interactor?.request(FillAboutMe.Next.Request(name: self.rootView.name ?? "", about: self.rootView.aboutMe ?? ""))
            case .back:
                self.router?.back()
            }
        }
    }
}

extension FillAboutMeViewController {
    func display(_ viewModel: FillAboutMe.Next.ViewModel) {
        self.router?.next()
    }
}
