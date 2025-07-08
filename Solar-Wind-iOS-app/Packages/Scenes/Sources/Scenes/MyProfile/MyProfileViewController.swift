//
//  MyProfileViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 04.07.2025.
//

import UIKit

final class MyProfileViewController: UIViewController {
    private lazy var rootView = MyProfileView()
    var router: MyProfileRouter?
    var interactor: MyProfileInteractor?
    
    override func loadView() {
        view = rootView
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .back:
                self.router?.back()
            case .logout:
                self.interactor?.logout()
            }
        }
    }
}

extension MyProfileViewController {
    func logout() {
        router?.logout()
    }
}
