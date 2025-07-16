//
//  EditAboutMeViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 15.07.2025.
//

import UIKit

final class EditAboutMeViewController: UIViewController {
    var router: EditAboutMeRouter?
    var interactor: EditAboutMeInteractor?

    private lazy var rootView = EditAboutMeView()

    override func loadView() {
        view = rootView
        hideKeyboardWhenTappedAround()

        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .save:
//                self.interactor?.request(EditAboutMe.Save.Request())
            case .back:
//                self.interactor?.back()
            case .searchCity(_):
                
            case .searchSport(_):
                
            }
        }
    }
}
