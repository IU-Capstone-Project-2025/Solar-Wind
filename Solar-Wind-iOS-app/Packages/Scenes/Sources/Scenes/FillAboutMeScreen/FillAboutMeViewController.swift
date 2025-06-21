//
//  FillAboutMeViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

import UIKit

final class FillAboutMeViewController: UIViewController {
    var router: FillAboutMeRouter?
    
    private lazy var rootView = FillAboutMeView()
    
    override func loadView() {
        view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                router?.next()
            }
        }
    }
}
