//
//  EditAboutMeBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 15.07.2025.
//

public final class EditAboutMeBuilder {
    @MainActor static func build() ->EditAboutMeViewController {
        let vc = EditAboutMeViewController()
        let worker = EditAboutMeWorker()
        let presenter = EditAboutMePresenter()
        let interactor = EditAboutMeInteractor(worker: worker, presenter: presenter)
        let router = EditAboutMeRouter()
        vc.interactor = interactor
        vc.router = router
        router.vc = vc
        presenter.view = vc
        return vc
    }
}
