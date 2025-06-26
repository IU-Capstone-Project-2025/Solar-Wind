//
//  ChooseCityInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 19.06.2025.
//

import Foundation

final  class ChooseCityInteractor: @unchecked Sendable {
    private var presenter: ChooseCityPresenter
    private var worker: ChooseCityWorker
    public var cities: [ChooseCity.City] = []
    private var searchText: String = ""
    private var currentPage = -1
    private let pageSize = 20
    private var isLoading = false
    
    init(presenter: ChooseCityPresenter, worker: ChooseCityWorker) {
        self.presenter = presenter
        self.worker = worker
        loadMoreData()
    }
    
    @MainActor public func requset(_ request: ChooseCity.Next.Request) {
        self.presenter.present(ChooseCity.Next.ViewModel())
    }
    
    func loadMoreData() {
//        self.cities = [
//            ChooseCity.City(id: -1, name: "Белгород"),
//            ChooseCity.City(id: -2, name: "Воронеж"),
//            ChooseCity.City(id: -3, name: "Калининград"),
//            ChooseCity.City(id: -4, name: "Томск"),
//            ChooseCity.City(id: -5, name: "Пермь"),
//            ChooseCity.City(id: -6, name: "Ярославль"),
//            ChooseCity.City(id: -7, name: "Иркутск"),
//            ChooseCity.City(id: -8, name: "Ульяновск"),
//            ChooseCity.City(id: -9, name: "Тула"),
//            ChooseCity.City(id: -10, name: "Киров"),
//            ChooseCity.City(id: -11, name: "Смоленск"),
//            ChooseCity.City(id: -12, name: "Барнаул"),
//            ChooseCity.City(id: -13, name: "Мурманск"),
//            ChooseCity.City(id: -14, name: "Петрозаводск"),
//            ChooseCity.City(id: -15, name: "Сочи"),
//            ChooseCity.City(id: -16, name: "Архангельск"),
//            ChooseCity.City(id: -17, name: "Чебоксары"),
//            ChooseCity.City(id: -18, name: "Новороссийск"),
//            ChooseCity.City(id: -19, name: "Кострома"),
//            ChooseCity.City(id: -20, name: "Владикавказ")
//        ]

        // Отдаём заглушки в презентер
//        DispatchQueue.main.async{ self.presenter.present(cities: self.cities)}
        guard !isLoading else { return }
        isLoading = true
        currentPage += 1
        
        worker.search(page: currentPage, size: pageSize, text: searchText) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let cities):
                let newCities = cities.items
                self.cities.append(contentsOf: newCities)
                
                DispatchQueue.main.async {
                    self.presenter.present(cities: self.cities.map { ChooseCity.City(id: $0.id, name: $0.name) })
                }
                
            case .failure(let error):
                print("Error loading more cities: \(error)") // Ошибки можно и в фоне логировать
            }
        }
    }
    
    func saveSelectedCity(_ city: ChooseCity.City) {
        let data = try? JSONEncoder().encode(city)
        UserDefaults.standard.set(data, forKey: "selectedCity")
    }
}
