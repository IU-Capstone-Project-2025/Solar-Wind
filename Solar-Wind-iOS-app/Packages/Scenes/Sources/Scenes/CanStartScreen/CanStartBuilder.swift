//
//  CanStartBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import UIKit

final class CanStartBuilder {
    @MainActor public static func build() -> UIViewController {
        let vc = CanStartViewController()
        let router = CanStartRouter()
        router.vc = vc
        vc.router = router
        return vc
    }
}
