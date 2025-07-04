//
//  ChooseTimeViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit

final class ChooseTimeViewController: UIViewController {
    var router: ChooseTimeRouter?
    
    private lazy var rootView = ChooseTimeView()
    
    override func loadView() {
        view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                router?.next()
            case .back:
                self.router?.back()
            }
        }
    }
}
