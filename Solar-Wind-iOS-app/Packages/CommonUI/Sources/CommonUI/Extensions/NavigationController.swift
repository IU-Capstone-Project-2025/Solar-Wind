//
//  NavigationController.swift
//  CommonUI
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit

open class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarHidden(true, animated: false)
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}

public extension UINavigationController {
    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        pushViewController(viewController, animated: animated)
        guard let completion = completion else { return }
        if animated, let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        }
        else {
            completion()
        }
    }
}
