//
//  ChooseTimeBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit

public final class ChooseTimeBuilder {
    @MainActor public static func build() -> UIViewController {
        let vc = ChooseTimeViewController()
        let router = ChooseTimeRouter()
        let worker = ChooseTimeWorker()
        let presenter = ChooseTimePresenter()
        let interactor = ChooseTimeInteractor(worker: worker, presenter: presenter)
        presenter.view = vc
        vc.interactor = interactor
        router.vc = vc
        vc.router = router
        return vc
    }
}
