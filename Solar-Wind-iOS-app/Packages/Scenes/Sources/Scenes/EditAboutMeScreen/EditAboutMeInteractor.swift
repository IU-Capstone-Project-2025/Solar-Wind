//
//  EditAboutMeInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 15.07.2025.
//

import Foundation

final class EditAboutMeInteractor: @unchecked Sendable {
    let worker: EditAboutMeWorker
    let presenter: EditAboutMePresenter
    
    var categories: [ChooseCategory.Category] = []
    var selectedCategories: [ChooseCategory.Category] = [] {
        didSet {
//            DispatchQueue.main.async { self.presenter.present()
        }
    }
    var selectedCategoriesIds: [Int] = []
    
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
    
    func request(_ request: EditAboutMe.SearchSport.Request) {
        worker.findSport(word: request.word) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                self.categories = model.items
//                DispatchQueue.main.async { self.presenter.present() }
            case .failure(let error):
                print("Error loading more categories: \(error)")
            }
        }
    }
    
    public var cities: [ChooseCity.City] = []
    private var searchText: String = ""
    public var selectedCityId: Int?
    
    public func request(_ request: EditAboutMe.SearchCity.Request) {
        worker.findCity(word: request.word) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model):
                self.cities = model.items
                DispatchQueue.main.async {
//                    self.presenter.present(cities: self.cities.map { ChooseCity.City(id: $0.id, name: $0.name) })
                }
            case .failure(let error):
                print("Error loading more cities: \(error)")
            }
        }
    }
    
    func saveSelectedCity(_ city: ChooseCity.City) {
        selectedCityId = city.id
        UserDefaults.standard.set(city.id, forKey: "selectedCityId")
    }
    
    init(worker: EditAboutMeWorker, presenter: EditAboutMePresenter) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func request(_ request: FillAboutMe.Next.Request) {
        guard !request.name.isEmpty else {
            return
        }
        worker.save() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                DispatchQueue.main.async{ self.presenter.present(EditAboutMe.Save.Response()) }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
