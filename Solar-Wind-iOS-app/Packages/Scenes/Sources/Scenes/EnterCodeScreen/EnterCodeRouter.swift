//
//  EnterCodeRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 13.07.2025.
//

final class EnterCodeRouter {
    weak var vc: EnterCodeViewController?
    @MainActor func toCity() {
        vc?.navigationController?.setViewControllers([ChooseCityBuilder.build()], animated: true)
    }
}
