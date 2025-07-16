//
//  AnotherUserProfileBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 30.06.2025.
//

import UIKit

public final class AnotherUserProfileBuilder {
    @MainActor public static func build(userId: Int) -> UIViewController {
        let vc = AnotherUserProfileViewConrtroller()
        let router = AnotherUserProfileRouter()
        let presenter = AnotherUserProfilePresenter(view: vc)
        let worker = AnotherUserProfileWorker()
        vc.router = router
        router.vc = vc
        let interactor = AnotherUserProfileInteractor(presenter: presenter, worker: worker, userId: userId)
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
