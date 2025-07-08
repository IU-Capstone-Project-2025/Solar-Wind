//
//  FeedViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import UIKit

final class FeedViewController: UIViewController {
    private lazy var rootView = FeedView()
    var presenter: FeedPresenter?
    var interactor: FeedInteractor?
    var router: FeedRouter?
    
    override func loadView() {
        view = rootView
        rootView.setDelegate(rootView)
        
        rootView.actionHandler = { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .selected(let index):
                interactor?.request(Feed.Select.Request(userId: index))
            case .liked(_):
                return
            case .myProfile:
                router?.myProfile()
            }
        }
        
        interactor?.loadInitialData()
    }
}

extension FeedViewController {
    func display(_ viewModel: Feed.Select.ViewModel, id: Int) {
        router?.openUser(with: id)
    }
    
    func display(_ viewModel: Feed.Fetch.ViewModel) {
        rootView.viewModel = viewModel.root
    }
}
