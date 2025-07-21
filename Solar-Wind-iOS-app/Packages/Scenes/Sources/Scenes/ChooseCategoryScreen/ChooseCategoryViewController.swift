//
//  ChooseCategoryViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit

import UIKit

import UIKit

public final class ChooseCategoryViewController: UIViewController {
    private lazy var rootView = ChooseCategoryView()
    var interactor: ChooseCategoryInteractor?
    var router: ChooseCategoryRouter?

    public override func loadView() {
        view = rootView
        hideKeyboardWhenTappedAround()

        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                self.interactor?.request(ChooseCategory.Next.Request())
            case .selected(let id):
                self.interactor?.toggleCategory(with: id)
            case .add:
                self.interactor?.loadMoreData()
            case .back:
                self.router?.back()
            case .search(let word):
                self.interactor?.request(ChooseCategory.Search.Request(word: word))
            }
        }
    }
}

extension ChooseCategoryViewController {
    func display(_ viewModel: ChooseCategory.Add.ViewModel) {
        rootView.viewModel = viewModel.root
    }

    func updateSelectedTags(_ selected: [ChooseCategory.Category]) {
        rootView.selectedCategories = selected
    }
}
