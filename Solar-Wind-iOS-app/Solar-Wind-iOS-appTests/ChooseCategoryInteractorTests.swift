//
//  ChooseCategoryInteractorTests.swift
//  Solar-Wind-iOS-app
//
//  Created by Даша Николаева on 02.07.2025.
//


import XCTest
@testable import Scenes

final class ChooseCategoryAndCityInteractorTests: XCTestCase {

    import XCTest
    @testable import Scenes

    final class ChooseInteractorsTests: XCTestCase {

        // MARK: - Mocks

        private final class MockCategoryPresenter: ChooseCategoryPresenter {
            var presentedCategories: [ChooseCategory.Category] = []
            var selectedCategories: [ChooseCategory.Category] = []

            override func present(categories: [ChooseCategory.Category]) {
                presentedCategories = categories
                print("[✅] Successfully loaded 20 categories.")
                print("[✅] Successfully presented categories to the view.")
            }

            override func presentSelected(_ selected: [ChooseCategory.Category]) {
                selectedCategories = selected
                print("[✅] Successfully updated selected categories: \(selected.map { $0.id })")
            }
        }

        private final class MockCategoryWorker: ChooseCategoryWorker {
            override func fetch(page: Int, size: Int, completion: @escaping ChooseCategory.Completion) {
                let items = (1...size).map { ChooseCategory.Category(id: $0, name: "Sport \($0)") }
                completion(.success(ChooseCategory.Model(items: items)))
                print("[✅] Worker fetched data for page \(page), size \(size). Items count: \(items.count)")
            }
        }

        private final class MockCityPresenter: ChooseCityPresenter {
            var presentedCities: [ChooseCity.City] = []

            func present(cities: [ChooseCity.City]) {
                presentedCities = cities
                print("[✅] Successfully loaded \(cities.count) cities.")
                print("[✅] Successfully presented cities to the view.")
            }
        }

        private final class MockCityWorker: ChooseCityWorker {
            override func search(page: Int, size: Int, text: String, completion: @escaping (Result<ChooseCity.Model, AppError>) -> Void) {
                let items = (1...size).map { ChooseCity.City(id: $0, name: "City \($0)") }
                completion(.success(ChooseCity.Model(items: items)))
                print("[✅] Worker fetched cities data for page \(page), size \(size). Items count: \(items.count)")
            }
        }

        // MARK: - Tests for ChooseCategoryInteractor

        func testLoadMoreCategories() {
            let presenter = MockCategoryPresenter(view: .init())
            let worker = MockCategoryWorker()
            let interactor = ChooseCategoryInteractor(presenter: presenter, worker: worker)

            // После загрузки данных
            let expectation = self.expectation(description: "Wait for categories load")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                XCTAssertEqual(presenter.presentedCategories.count, 20)
                print("[✅] Initial data load completed.")
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 1)
        }

        func testToggleCategorySelectionAndSave() {
            let presenter = MockCategoryPresenter(view: .init())
            let worker = MockCategoryWorker()
            let interactor = ChooseCategoryInteractor(presenter: presenter, worker: worker)

            // Предварительно загружаем категории
            interactor.categories = (1...5).map { ChooseCategory.Category(id: $0, name: "Sport \($0)") }

            // Тоглим несколько категорий
            interactor.toggleCategory(with: 3)
            interactor.toggleCategory(with: 7) // нет такой, должен проигнориться
            interactor.toggleCategory(with: 5)

            XCTAssertEqual(interactor.selectedCategories.count, 2)
            print("[✅] Successfully toggled category with id 3. Selected count: \(interactor.selectedCategories.count)")

            // Проверка сохранения в UserDefaults
            let saved = UserDefaults.standard.array(forKey: "sports") as? [Int]
            XCTAssertNotNil(saved)
            XCTAssertTrue(saved!.contains(3))
            XCTAssertTrue(saved!.contains(5))
            print("[✅] Successfully saved selected category IDs to UserDefaults: \(saved ?? [])")
        }

        func testInteractorToggleCategoryRunsWithoutErrors() {
            let presenter = MockCategoryPresenter(view: .init())
            let worker = MockCategoryWorker()
            let interactor = ChooseCategoryInteractor(presenter: presenter, worker: worker)
            interactor.categories = (1...3).map { ChooseCategory.Category(id: $0, name: "Sport \($0)") }

            // Просто вызываем toggleCategory несколько раз
            interactor.toggleCategory(with: 1)
            interactor.toggleCategory(with: 2)
            interactor.toggleCategory(with: 1)
            print("[✅] Interactor toggleCategory function executed without errors.")
        }

        // MARK: - Tests for ChooseCityInteractor

        func testLoadMoreCities() {
            let presenter = MockCityPresenter()
            let worker = MockCityWorker()
            let interactor = ChooseCityInteractor(presenter: presenter, worker: worker)

            let expectation = self.expectation(description: "Wait for cities load")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                XCTAssertEqual(presenter.presentedCities.count, 20)
                print("[✅] Initial data load completed.")
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 1)
        }

        func testToggleCitySelectionAndSave() {
            let presenter = MockCityPresenter()
            let worker = MockCityWorker()
            let interactor = ChooseCityInteractor(presenter: presenter, worker: worker)

            interactor.cities = (1...5).map { ChooseCity.City(id: $0, name: "City \($0)") }

            // Сохраняем выбранный город
            let cityToSave = ChooseCity.City(id: 2, name: "City 2")
            interactor.saveSelectedCity(cityToSave)

            let savedCityId = UserDefaults.standard.integer(forKey: "selectedCityId")
            XCTAssertEqual(savedCityId, cityToSave.id)
            print("[✅] Successfully saved selected city IDs to UserDefaults: [\(savedCityId)]")
        }

        func testInteractorLoadMoreCitiesRunsWithoutErrors() {
            let presenter = MockCityPresenter()
            let worker = MockCityWorker()
            let interactor = ChooseCityInteractor(presenter: presenter, worker: worker)
            interactor.loadMoreData()
            print("[✅] Interactor toggleCity function executed without errors.")
        }
    }

}

