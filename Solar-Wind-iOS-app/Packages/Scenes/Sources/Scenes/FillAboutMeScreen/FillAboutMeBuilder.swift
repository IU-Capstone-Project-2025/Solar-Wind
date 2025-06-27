//
//  FillAboutMeBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

import UIKit

final class FillAboutMeBuilder {
    @MainActor public static func build() -> UIViewController {
        let vc = FillAboutMeViewController()
        let router = FillAboutMeRouter()
        vc.router = router
        router.vc = vc
        return vc
    }
}
