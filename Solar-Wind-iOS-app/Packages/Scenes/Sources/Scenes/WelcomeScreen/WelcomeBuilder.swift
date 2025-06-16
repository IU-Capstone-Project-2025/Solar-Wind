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
        let presenter = WelcomePresenter()
        let worker = WelcomeWorker()
        let interactor = WelcomeInteractor(
            presenter: presenter,
            worker: worker
        )
        let router = WelcomeRouter()
        router.vc = vc
        presenter.router = router
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
