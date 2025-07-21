//
//  SwiftUIHostingView.swift
//  CommonUI
//
//  Created by Даша Николаева on 01.07.2025.
//

import SwiftUI
import UIKit

public final class SwiftUIHostingView<Content: SwiftUI.View>: UIView {
    private var hostingController: UIHostingController<Content>?
    private var heightConstraint: NSLayoutConstraint?
    
    private var rootView: Content?

    public init(rootView: Content) {
        super.init(frame: .zero)
        self.rootView = rootView
        setup(rootView: rootView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(rootView: Content) {
        self.translatesAutoresizingMaskIntoConstraints = false

        var view = rootView

        let controller = UIHostingController(rootView: view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear

        addSubview(controller.view)
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: bottomAnchor),
            controller.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        self.hostingController = controller
    }

    public func update(rootView: Content) {
        hostingController?.rootView = rootView
    }
}
