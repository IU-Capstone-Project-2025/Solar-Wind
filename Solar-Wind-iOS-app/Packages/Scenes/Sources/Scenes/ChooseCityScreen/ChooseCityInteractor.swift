//
//  ChooseCityInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 19.06.2025.
//

final class ChooseCityInteractor {
    private var presenter: ChooseCityPresenter
    private var worker: ChooseCityWorker
    
    init(presenter: ChooseCityPresenter, worker: ChooseCityWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    @MainActor public func requset(_ request: ChooseCity.Next.Request) {
        self.presenter.present(ChooseCity.Next.ViewModel())
    }
}
