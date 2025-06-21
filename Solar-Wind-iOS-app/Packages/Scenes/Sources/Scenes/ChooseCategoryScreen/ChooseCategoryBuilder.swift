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
        router.vc = vc
        vc.router = router
        return vc
    }
}
