//
//  FillAboutMeRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 22.06.2025.
//

final class FillAboutMeRouter {
    weak var vc: FillAboutMeViewController?
    
    @MainActor func next() {
        vc?.navigationController?.setViewControllers([], animated: true)
    }
}
