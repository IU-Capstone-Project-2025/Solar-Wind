//
//  WelcomeBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

import UIKit

public final class WelcomeBuilder {
    @MainActor public static func build() -> UIViewController {
        let vc = WelcomeViewController()
        let interactor = WelcomeInteractor(
            presenter: WelcomePresenter(),
            worker: WelcomeWorker()
        )
        let router = WelcomeRouter()
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
