//
//  FeedViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import UIKit

final class FeedViewController: UIViewController {
    private lazy var rootView = FeedView()
    private lazy var presenter = FeedPresenter()
    private lazy var interactor = FeedInteractor(presenter: presenter)
    
    override func loadView() {
        view = rootView
        presenter.view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .selected(let index):
                print("Selected user at index: \(index)")
            }
        }
        
        // Загрузка данных при открытии
        interactor.loadInitialData()
    }
}
