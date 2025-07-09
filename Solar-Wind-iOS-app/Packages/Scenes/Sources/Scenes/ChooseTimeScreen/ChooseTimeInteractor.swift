//
//  ChooseTimeInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 22.06.2025.
//

import Foundation

final class ChooseTimeInteractor: @unchecked Sendable {
    let worker: ChooseTimeWorker
    let presenter: ChooseTimePresenter
    
    var selectedDays: [Int] = []
    
    init(worker: ChooseTimeWorker, presenter: ChooseTimePresenter) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func request(_ request: ChooseTime.Next.Request) {
        if !selectedDays.isEmpty {
            worker.save(selectedDays)
            DispatchQueue.main.async { [weak self] in
                self?.presenter.present(ChooseTime.Next.Response())
            }
        }
    }
    
    func request(_ request: ChooseTime.Select.Request) {
        if selectedDays.contains(request.dayId) {
            selectedDays.remove(at: selectedDays.firstIndex(of: request.dayId)!)
        } else {
            selectedDays.append(request.dayId)
        }
    }
}
