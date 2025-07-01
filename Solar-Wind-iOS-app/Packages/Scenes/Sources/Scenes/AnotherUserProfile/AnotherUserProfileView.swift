//
//  AnotherUserProfileView.swift
//  Scenes
//
//  Created by Даша Николаева on 30.06.2025.
//

import UIKit
import CommonUI

final class AnotherUserProfileView: View {
    var viewModel: AnotherUserProfile.RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            image.update(rootView: ImageWithFooter(image: UIImage(named: "avatarPlaceholder")!, name: viewModel.username, city: viewModel.city))
            tagsView.update(rootView: TagsView(tags: viewModel.sports))
        }
    }
    
    private lazy var header = addGradientHeader(backButton: true)
    
    private var image = SwiftUIHostingView(rootView: ImageWithFooter(image: UIImage(named: "avatarPlaceholder")!, name: "", city: ""))
    
    private lazy var tagsView = SwiftUIHostingView(rootView: TagsView())
    
    override func setupContent() {
        super.setupContent()
        backgroundColor = .white
        addSubview(image)
        addSubview(header)
        addSubview(tagsView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: header.bottomAnchor),
            image.leftAnchor.constraint(equalTo: leftAnchor),
            image.rightAnchor.constraint(equalTo: rightAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),
            
            tagsView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),
            tagsView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            tagsView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            tagsView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
