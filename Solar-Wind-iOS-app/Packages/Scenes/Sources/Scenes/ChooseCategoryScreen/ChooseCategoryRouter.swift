//
//  ChooseCategoryRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

final class ChooseCategoryRouter {
    weak var vc: ChooseCategoryViewController?
    
    @MainActor func next() {
        vc?.navigationController?.pushViewController(ChooseTimeBuilder.build(), animated: true)
    }
    
    @MainActor func back() {
        vc?.navigationController?.popViewController(animated: true)
    }
}
