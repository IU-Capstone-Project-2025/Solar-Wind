//
//  FeedPresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

final class FeedPresenter {
    weak var view: FeedView?
    
    @MainActor func present(users: [Feed.RootViewModel.User]) {
        let viewModel = Feed.RootViewModel(
            sections: [.items(users)],
            currentItemsCount: users.count
        )
        view?.viewModel = viewModel
    }
}
