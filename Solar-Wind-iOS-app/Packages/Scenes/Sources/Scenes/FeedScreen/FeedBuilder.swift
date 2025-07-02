//
//  FeedBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import UIKit

final class FeedBuilder {
    @MainActor public static func build() -> UIViewController {
        let vc = FeedViewController()
        let router = FeedRouter()
        let presenter = FeedPresenter()
        let interactor = FeedInteractor(presenter: presenter)
        presenter.vc = vc
        router.vc = vc
        vc.router = router
        vc.interactor = interactor
        return vc
    }
}
