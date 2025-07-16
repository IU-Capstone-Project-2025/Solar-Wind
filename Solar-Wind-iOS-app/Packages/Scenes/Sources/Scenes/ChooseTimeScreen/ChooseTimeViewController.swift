//
//  ChooseTimeViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit

final class ChooseTimeViewController: UIViewController {
    var router: ChooseTimeRouter?
    var interactor: ChooseTimeInteractor?
    
    private lazy var rootView = ChooseTimeView()
    
    override func loadView() {
        view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                self.interactor?.request(ChooseTime.Next.Request())
            case .back:
                self.router?.back()
            case .select(let dayId):
                self.interactor?.request(ChooseTime.Select.Request(dayId: dayId))
            }
        }
    }
}

extension ChooseTimeViewController {
    func display(_ viewModel: ChooseTime.Next.ViewModel) {
        router?.next()
    }
}
