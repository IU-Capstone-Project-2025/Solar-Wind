//
//  ChooseCityViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit

class ChooseCityViewController: UIViewController {
    private lazy var rootView = ChooseCityView()
    
    var interactor: ChooseCityInteractor?
    var router: ChooseCityRouter?
    
    override func loadView() {
        view = rootView
        hideKeyboardWhenTappedAround()
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                self.interactor?.request(ChooseCity.Next.Request())
            case .selected(let index):
                guard let city = self.interactor?.cities[index] else { return }
                self.interactor?.saveSelectedCity(city)
                rootView.setSelectedCity(city)
            case .add:
                self.interactor?.loadMoreData()
            case .back:
                self.router?.back()
            case .search(let word):
                self.interactor?.request(ChooseCity.Search.Request(word: word))
            }
        }
    }
}

extension ChooseCityViewController {
    func display(_ viewModel: ChooseCity.Add.ViewModel) {
        rootView.viewModel = viewModel.root
    }
}
