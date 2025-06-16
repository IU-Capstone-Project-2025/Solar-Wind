//
//  VerificationViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit

final class VerificationViewController: UIViewController {
    var router: VerificationRoutingLogic?
    
    private lazy var rootView = VerificationView()
    
    override func loadView() {
        view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .openTelegram:
                router?.toCity()
            }
        }
    }
}
