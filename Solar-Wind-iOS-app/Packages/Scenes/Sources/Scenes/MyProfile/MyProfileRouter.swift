//
//  MyProfileRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 04.07.2025.
//

final class MyProfileRouter {
    weak var vc: MyProfileViewController?
    
    @MainActor func back() {
        vc?.navigationController?.popViewController(animated: true)
    }
    
    @MainActor func logout() {
        vc?.navigationController?.setViewControllers([WelcomeBuilder.build()], animated: true)
    }
}
