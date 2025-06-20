//
//  ChooseCityViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit

class ChooseCityViewController: UIViewController {
    private lazy var rootView = ChooseCityView()
    
    override func loadView() {
        view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                return
            }
        }
    }
}
