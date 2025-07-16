//
//  EnterCodeBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 13.07.2025.
//

final class EnterCodeBuilder {
    @MainActor public static func build() -> EnterCodeViewController {
        let vc = EnterCodeViewController()
        let presenter = EnterCodePresenter()
        let worker = EnterCodeWorker()
        let interactor = EnterCodeInteractor(worker: worker, presenter: presenter)
        let router = EnterCodeRouter()
        vc.interactor = interactor
        vc.router = router
        presenter.view = vc
        router.vc = vc
        return vc
    }
}
