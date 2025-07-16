//
//  EnterCodeInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 13.07.2025.
//

import Foundation

final class EnterCodeInteractor: @unchecked Sendable {
    let worker: EnterCodeWorker
    let presenter: EnterCodePresenter
    
    init(worker: EnterCodeWorker, presenter: EnterCodePresenter) {
        self.worker = worker
        self.presenter = presenter
    }
    
    @MainActor func request(_ request: EnterCode.Next.Request) {
        worker.enterCode(code: request.code) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.presenter.present(response)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
