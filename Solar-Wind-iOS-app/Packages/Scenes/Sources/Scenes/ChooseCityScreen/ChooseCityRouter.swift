//
//  ChooseCityRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

final class ChooseCityRouter {
    weak var vc: ChooseCityViewController?
    
    @MainActor func next() {
        vc?.navigationController?.pushViewController(ChooseCategoryBuilder.build(), animated: true)
    }
    
    @MainActor func back() {
        vc?.navigationController?.popViewController(animated: true)
    }
}
