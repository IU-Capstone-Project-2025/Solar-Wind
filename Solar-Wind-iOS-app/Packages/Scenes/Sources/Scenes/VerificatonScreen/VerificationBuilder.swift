//
//  VerificationBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit

final class VerificationBuilder {
    @MainActor public static func build() -> UIViewController {
        let vc = VerificationViewController()
        let router = VerificationRouter()
        router.vc = vc
        vc.router = router
        return vc
    }
}
