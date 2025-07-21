//
//  ChooseTimeRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 22.06.2025.
//

final class ChooseTimeRouter {
    weak var vc: ChooseTimeViewController?
    @MainActor func next() {
        vc?.navigationController?.pushViewController(FillAboutMeBuilder.build(), animated: true)
    }
    @MainActor func back() {
        vc?.navigationController?.popViewController(animated: true)
    }
}
