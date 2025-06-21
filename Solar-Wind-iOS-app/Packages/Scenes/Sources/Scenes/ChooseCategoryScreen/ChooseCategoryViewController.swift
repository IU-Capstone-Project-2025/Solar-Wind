//
//  ChooseCategoryViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit

public final class ChooseCategoryViewController: UIViewController {
    private lazy var rootView = ChooseCategoryView()
    
    var router: ChooseCategoryRouter?
    
    public override func loadView() {
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
