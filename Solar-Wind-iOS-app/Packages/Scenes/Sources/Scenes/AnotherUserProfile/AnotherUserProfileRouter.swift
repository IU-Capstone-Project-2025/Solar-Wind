//
//  AnotherUserProfileRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 30.06.2025.
//

final class AnotherUserProfileRouter {
    weak var vc: AnotherUserProfileViewConrtroller?
    
    @MainActor func back() {
        self.vc?.navigationController?.popViewController(animated: true)
    }
}
