//
//  ChooseCityPresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

final class ChooseCityPresenter {
    weak var view: ChooseCityViewController?
    init(view: ChooseCityViewController) {
        self.view = view
    }
    
    var router: ChooseCityRouter?
    
    @MainActor func present(_ viewModel: ChooseCity.Next.ViewModel) {
        self.router?.next()
    }
    
    @MainActor
    func present(cities: [ChooseCity.City]) {
        let viewModel = ChooseCity.RootViewModel(
            sections: [.items(cities)],
            currentItemsCount: cities.count
        )
        view?.display(ChooseCity.Add.ViewModel(root: viewModel))
    }
}
