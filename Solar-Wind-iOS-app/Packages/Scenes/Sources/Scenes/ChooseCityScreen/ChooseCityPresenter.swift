//
//  ChooseCityPresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

final class ChooseCityPresenter {
    var router: ChooseCityRouter?
    
    @MainActor func present(_ viewModel: ChooseCity.Next.ViewModel) {
        self.router?.next()
    }
}
