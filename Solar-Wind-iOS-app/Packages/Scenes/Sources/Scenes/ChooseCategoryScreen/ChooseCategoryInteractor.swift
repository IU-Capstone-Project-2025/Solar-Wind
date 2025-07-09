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
//        self.categories = [
//            ChooseCategory.Category(id: -1, name: "Белгород"),
//            ChooseCategory.Category(id: -2, name: "Воронеж"),
//            ChooseCategory.Category(id: -3, name: "Калининград"),
//            ChooseCategory.Category(id: -4, name: "Томск"),
//            ChooseCategory.Category(id: -5, name: "Пермь"),
//            ChooseCategory.Category(id: -6, name: "Ярославль"),
//            ChooseCategory.Category(id: -7, name: "Иркутск"),
//            ChooseCategory.Category(id: -8, name: "Ульяновск"),
//            ChooseCategory.Category(id: -9, name: "Тула"),
//            ChooseCategory.Category(id: -10, name: "Киров"),
//            ChooseCategory.Category(id: -11, name: "Смоленск"),
//            ChooseCategory.Category(id: -12, name: "Барнаул"),
//            ChooseCategory.Category(id: -13, name: "Мурманск"),
//            ChooseCategory.Category(id: -14, name: "Петрозаводск"),
//            ChooseCategory.Category(id: -15, name: "Сочи"),
//            ChooseCategory.Category(id: -16, name: "Архангельск"),
//            ChooseCategory.Category(id: -17, name: "Чебоксары"),
//            ChooseCategory.Category(id: -18, name: "Новороссийск"),
//            ChooseCategory.Category(id: -19, name: "Кострома"),
//            ChooseCategory.Category(id: -20, name: "Владикавказ")
//        ]
//        DispatchQueue.main.async{ self.presenter.present(categories: self.categories)}
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
    
    func request(_ request: ChooseCategory.Search.Request) {
        worker.find(word: request.word) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                self.categories = model.items
                DispatchQueue.main.async { self.presenter.present(categories: self.categories) }
            case .failure(let error):
                print("Error loading more categories: \(error)")
            }
        }
    }
    
    func request(_ request: ChooseCategory.Next.Request) {
        if !selectedCategories.isEmpty {
            DispatchQueue.main.async { self.presenter.present(ChooseCategory.Next.ViewModel()) }
        }
    }
}
