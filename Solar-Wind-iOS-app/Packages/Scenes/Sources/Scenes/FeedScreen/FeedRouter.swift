//
//  FeedRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

final class FeedRouter {
    weak var vc: FeedViewController?
    
    @MainActor func openUser(with id: Int) {
        self.vc?.navigationController?.pushViewController(AnotherUserProfileBuilder.build(userId: id), animated: true)
    }
}
