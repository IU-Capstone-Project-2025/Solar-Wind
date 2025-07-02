//
//  CanStartRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

class CanStartRouter {
    weak var vc: CanStartViewController?
    
    @MainActor func next() {
        vc?.navigationController?.setViewControllers([FeedBuilder.build()], animated: true)
    }
}
