//
//  SwiftUIHostingView.swift
//  CommonUI
//
//  Created by Даша Николаева on 01.07.2025.
//

import SwiftUI
import UIKit

public final class SwiftUIHostingView<Content: SwiftUI.View>: SwiftUI.UIView {
    private var hostingController: UIHostingController<Content>?
    private var heightConstraint: NSLayoutConstraint?
    
    public init(rootView: Content) {
        super.init(frame: .zero)
        update(rootView: rootView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(rootView: Content) {
        if let hostingController = hostingController {
            hostingController.rootView = rootView
        } else {
            self.translatesAutoresizingMaskIntoConstraints = false
            let controller = UIHostingController(rootView: rootView)
            controller.view.backgroundColor = .clear
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(controller.view)
            NSLayoutConstraint.activate([
                controller.view.leadingAnchor.constraint(equalTo: leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: trailingAnchor),
                controller.view.topAnchor.constraint(equalTo: topAnchor),
                controller.view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            self.hostingController = controller
            
            // Для SwiftUI вью, которые сообщают свою высоту
            if var heightReportingView = rootView as? HeightReporting {
                heightConstraint = heightAnchor.constraint(equalToConstant: 0)
                heightConstraint?.isActive = true
                
                heightReportingView.onHeightChange = { [weak self] height in
                    self?.heightConstraint?.constant = height
                    self?.superview?.setNeedsLayout()
                }
            }
        }
    }
}

protocol HeightReporting {
    var onHeightChange: ((CGFloat) -> Void)? { get set }
}
