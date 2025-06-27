//
//  ChooseCategoryBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

public final class ChooseCategoryBuilder {
    @MainActor public static func build() -> ChooseCategoryViewController {
        let vc = ChooseCategoryViewController()
        let router = ChooseCategoryRouter()
        let presenter = ChooseCategoryPresenter(view: vc)
        let worker = ChooseCategoryWorker()
        let interactor = ChooseCategoryInteractor(presenter: presenter, worker: worker)
        router.vc = vc
        vc.router = router
        vc.interactor = interactor
        return vc
    }
}
