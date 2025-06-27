//
//  ChooseCategoryInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

import Foundation

final class ChooseCategoryInteractor: @unchecked Sendable {
    private let presenter: ChooseCategoryPresenter
    private let worker: ChooseCategoryWorker

    var categories: [ChooseCategory.Category] = []
    var selectedCategories: [ChooseCategory.Category] = [] {
        didSet { DispatchQueue.main.async { self.presenter.presentSelected(self.selectedCategories) }}
    }
    var selectedCategoriesIds: [Int] = []

    private var currentPage = 0
    private let pageSize = 20
    private var isLoading = false

    init(presenter: ChooseCategoryPresenter, worker: ChooseCategoryWorker) {
        self.presenter = presenter
        self.worker = worker
        loadMoreData()
    }

    func toggleCategory(with id: Int) {
        guard let category = categories.first(where: { $0.id == id }) else { return }
        if let index = selectedCategories.firstIndex(of: category) {
            selectedCategories.remove(at: index)
        } else {
            selectedCategories.append(category)
            selectedCategoriesIds.append(category.id)
            
            UserDefaults.standard.set(selectedCategoriesIds, forKey: "sports")
        }
    }

    func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true
        currentPage += 1

        worker.fetch(page: currentPage, size: pageSize) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let model):
                self.categories.append(contentsOf: model.items)
                DispatchQueue.main.async { self.presenter.present(categories: self.categories) }
            case .failure(let error):
                print("Error loading more categories: \(error)")
            }
        }
    }
}
