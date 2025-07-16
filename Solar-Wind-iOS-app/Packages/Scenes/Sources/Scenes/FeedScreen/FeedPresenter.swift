//
//  FeedPresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

final class FeedPresenter {
    weak var vc: FeedViewController?
    
    @MainActor func present(users: [Feed.RootViewModel.User]) {
        let viewModel = Feed.Fetch.ViewModel(root: .init(sections: [.items(users)], currentItemsCount: users.count))
        vc?.display(viewModel)
    }
    
    @MainActor func present(_ response: Feed.Select.Response, id: Int) {
        vc?.display(Feed.Select.ViewModel(), id: id)
    }
}
