//
//  ChooseCityBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit

final class ChooseCityBuilder {
    @MainActor public static func build() -> UIViewController {
        let vc = ChooseCityViewController()
        let worker = ChooseCityWorker()
        let presenter = ChooseCityPresenter(view: vc)
        let router = ChooseCityRouter()
        router.vc = vc
        presenter.router = router
        let interactor = ChooseCityInteractor(presenter: presenter, worker: worker)
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
