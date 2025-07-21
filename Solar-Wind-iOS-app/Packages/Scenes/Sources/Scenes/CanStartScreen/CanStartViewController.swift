//
//  CanStartViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import UIKit

class CanStartViewController: UIViewController {
    private lazy var rootView = CanStartView()
    
    var router: CanStartRouter?
    
    override func loadView() {
        view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                self.router?.next()
            }
        }
    }
}
