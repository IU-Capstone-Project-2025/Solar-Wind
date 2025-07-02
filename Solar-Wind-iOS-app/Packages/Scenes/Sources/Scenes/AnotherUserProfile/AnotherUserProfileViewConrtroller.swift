//
//  AnotherUserProfileViewConrtroller.swift
//  Scenes
//
//  Created by Даша Николаева on 30.06.2025.
//

import UIKit

public final class AnotherUserProfileViewConrtroller: UIViewController {
    private lazy var rootView = AnotherUserProfileView()
    var router: AnotherUserProfileRouter?
    var interactor: AnotherUserProfileInteractor?
    
    public override func loadView() {
        view = rootView
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.request(AnotherUserProfile.Fetch.Request())
    }
}


extension AnotherUserProfileViewConrtroller {
    func display(_ viewModel: AnotherUserProfile.Fetch.ViewModel) {
        rootView.viewModel = viewModel.root
    }
}
