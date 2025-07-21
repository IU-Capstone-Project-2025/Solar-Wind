//
//  AnotherUserProfileView.swift
//  Scenes
//
//  Created by Даша Николаева on 30.06.2025.
//

import UIKit
import CommonUI

final class AnotherUserProfileView: View {
    enum Action {
        case back
    }

    var actionHandler: (Action) -> Void = { _ in }
    
    private var isLiked: Bool = false
    var viewModel: AnotherUserProfile.RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            image.update(rootView: ImageWithFooter(image: UIImage(named: "avatarPlaceholder")!, name: viewModel.username, city: viewModel.city))
            tagsView.update(rootView: TagsView(tags: viewModel.sports))
            aboutView.text = viewModel.about
            daysView.update(rootView: DaysView(days: viewModel.days))
        }
    }
    
    private lazy var header = addGradientHeader(backButton: true) { [weak self] in
        self?.actionHandler(.back)
    }

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let daysViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .orangeColor.withAlphaComponent(0.2)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tagsViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .orangeColor.withAlphaComponent(0.2)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let aboutViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .orangeColor.withAlphaComponent(0.2)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var image = SwiftUIHostingView(rootView: ImageWithFooter(image: UIImage(named: "avatarPlaceholder")!, name: "", city: ""))

    private lazy var tagsView = SwiftUIHostingView(rootView: TagsView())

    private lazy var daysView = SwiftUIHostingView(rootView: DaysView(days: []))

    private lazy var aboutView: UILabel = {
        let view = UILabel()
        view.font = .size16Medium
        view.textColor = .black
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let likeView: HalfCircleView = {
        let view = HalfCircleView()
        let image = UIImage(systemName: "heart")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .medium)
        button.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func likeTapped() {
        isLiked.toggle()
        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .medium)
        likeButton.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart", withConfiguration: config), for: .normal)
        likeButton.tintColor = isLiked ? .darkPinkColor : .black
    }

    override func setupContent() {
        super.setupContent()
        backgroundColor = .white

        addSubview(header)
        addSubview(scrollView)
        addSubview(likeView)
        likeView.addSubview(likeButton)
        scrollView.addSubview(contentView)

        contentView.addSubview(image)
        contentView.addSubview(tagsViewBackground)
        contentView.addSubview(aboutViewBackground)
        contentView.addSubview(daysViewBackground)
        daysViewBackground.addSubview(daysView)
        tagsViewBackground.addSubview(tagsView)
        aboutViewBackground.addSubview(aboutView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        NSLayoutConstraint.activate([
            // header
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leftAnchor.constraint(equalTo: leftAnchor),
            header.rightAnchor.constraint(equalTo: rightAnchor),
            header.heightAnchor.constraint(equalToConstant: 100),

            // scrollView
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // contentView inside scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // image
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),

            // tagsView
            tagsViewBackground.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 70),
            tagsViewBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            tagsViewBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            tagsViewBackground.heightAnchor.constraint(equalToConstant: 100),

            // aboutView
            aboutViewBackground.topAnchor.constraint(equalTo: tagsViewBackground.bottomAnchor, constant: 20),
            aboutViewBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            aboutViewBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),

            // daysView
            daysViewBackground.topAnchor.constraint(equalTo: aboutViewBackground.bottomAnchor, constant: 20),
            daysViewBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            daysViewBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            daysViewBackground.heightAnchor.constraint(equalToConstant: 80),

            // bottom constraint to scroll
            daysViewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            
            likeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            likeView.rightAnchor.constraint(equalTo: rightAnchor),
            likeView.heightAnchor.constraint(equalToConstant: 120),
            likeView.widthAnchor.constraint(equalToConstant: 60),
            
            likeButton.centerXAnchor.constraint(equalTo: likeView.centerXAnchor),
            likeButton.centerYAnchor.constraint(equalTo: likeView.centerYAnchor),
            
            daysView.centerXAnchor.constraint(equalTo: daysViewBackground.centerXAnchor),
            daysView.centerYAnchor.constraint(equalTo: daysViewBackground.centerYAnchor),
            daysView.heightAnchor.constraint(equalTo: daysViewBackground.heightAnchor),
            daysView.widthAnchor.constraint(equalTo: daysViewBackground.widthAnchor),
            
            tagsView.rightAnchor.constraint(equalTo: tagsViewBackground.rightAnchor, constant: -10),
            tagsView.leftAnchor.constraint(equalTo: tagsViewBackground.leftAnchor, constant: 10),
            tagsView.centerYAnchor.constraint(equalTo: tagsViewBackground.centerYAnchor),
            tagsView.heightAnchor.constraint(equalTo: tagsViewBackground.heightAnchor),
            
            aboutView.topAnchor.constraint(equalTo: aboutViewBackground.topAnchor, constant: 10),
            aboutView.bottomAnchor.constraint(equalTo: aboutViewBackground.bottomAnchor, constant: -10),
            aboutView.rightAnchor.constraint(equalTo: aboutViewBackground.rightAnchor, constant: -10),
            aboutView.leftAnchor.constraint(equalTo: aboutViewBackground.leftAnchor, constant: 10)
        ])
    }
}
