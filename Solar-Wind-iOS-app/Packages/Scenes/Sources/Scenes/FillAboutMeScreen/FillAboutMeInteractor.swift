//
//  FillAboutMeInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 22.06.2025.
//

import Foundation

final class FillAboutMeInteractor: @unchecked Sendable {
    let worker: FillAboutMeWorker
    let presenter: FillAboutMePresenter
    
    init(worker: FillAboutMeWorker, presenter: FillAboutMePresenter) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func request(_ request: FillAboutMe.Next.Request) {
        guard !request.name.isEmpty else {
            return
        }
        worker.save(name: request.name, aboutMe: request.about) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                DispatchQueue.main.async{ self.presenter.present(FillAboutMe.Next.Response()) }
            case .failure(let error):
                print(error)
            }
        }
    }
}
