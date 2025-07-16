//
//  ChooseCategoryPresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

final class ChooseCategoryPresenter {
    weak var view: ChooseCategoryViewController?
    var router: ChooseCategoryRouter?

    init(view: ChooseCategoryViewController) {
        self.view = view
    }

    @MainActor func present(categories: [ChooseCategory.Category]) {
        let viewModel = ChooseCategory.RootViewModel(
            sections: [.items(categories)],
            currentItemsCount: categories.count,
            selectedCategories: []
        )

        view?.display(ChooseCategory.Add.ViewModel(root: viewModel))
    }

    @MainActor func presentSelected(_ selected: [ChooseCategory.Category]) {
        view?.updateSelectedTags(selected)
    }
    
    @MainActor func present(_ viewModel: ChooseCategory.Next.ViewModel) {
        router?.next()
    }
}
