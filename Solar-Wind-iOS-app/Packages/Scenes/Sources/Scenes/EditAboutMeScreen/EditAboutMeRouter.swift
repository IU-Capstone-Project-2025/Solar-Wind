//
//  EditAboutMeRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 15.07.2025.
//

final class EditAboutMeRouter {
    weak var vc: EditAboutMeViewController?
    
    @MainActor func back() {
        vc?.navigationController?.popViewController(animated: true)
    }
}
