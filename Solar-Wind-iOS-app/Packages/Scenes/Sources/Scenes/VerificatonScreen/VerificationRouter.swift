//
//  VerificationRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

class VerificationRouter: @preconcurrency VerificationRoutingLogic {
    weak var vc: VerificationViewController?
    @MainActor func toEnterCode() {
        vc?.navigationController?.setViewControllers([EnterCodeBuilder.build()], animated: true)
    }
    
}
