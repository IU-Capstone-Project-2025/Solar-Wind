//
//  WelcomeRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

import UIKit

final class WelcomeRouter: @preconcurrency WelcomeRoutingLogic {
    weak var vc: UIViewController?
    
    @MainActor func next() {
        vc?.navigationController?.setViewControllers([VerificationBuilder.build()], animated: true)
    }
}
