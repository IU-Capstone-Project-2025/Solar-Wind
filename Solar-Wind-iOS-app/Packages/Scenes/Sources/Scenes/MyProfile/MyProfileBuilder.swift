//
//  MyProfileBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 04.07.2025.
//

public final class MyProfileBuilder {
    @MainActor static func build() -> MyProfileViewController {
        let vc = MyProfileViewController()
        let presenter = MyProfilePresenter()
        presenter.view = vc
        let interactor = MyProfileInteractor(presenter: presenter)
        vc.interactor = interactor
        let router = MyProfileRouter()
        router.vc = vc
        vc.router = router
        return vc
    }
}
