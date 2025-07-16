//
//  MyProfileView.swift
//  Scenes
//
//  Created by Даша Николаева on 04.07.2025.
//

import UIKit
import CommonUI

final class MyProfileView: View {
    enum Action {
        case logout
        case back
        case edit
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    var viewModel: MyProfile.RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            image.update(rootView: ImageWithFooter(image: UIImage(named: "avatarPlaceholder")!, name: viewModel.username, city: viewModel.city))
            tagsView.update(rootView: TagsView(tags: viewModel.sports))
            aboutView.text = viewModel.about
            daysView.update(rootView: DaysView(days: viewModel.days))
        }
    }
    
    lazy var header = addGradientHeader(text: "My profile", backButton: true, rightButton: true, rightButtonActoin: {[weak self] in
        self?.actionHandler(.edit)}) { [weak self] in
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

    private lazy var image = SwiftUIHostingView(rootView: ImageWithFooter(image: UIImage(named: "avatarPlaceholder")!, name: "", city: ""))

    private lazy var tagsView = SwiftUIHostingView(rootView: TagsView())

    private lazy var daysView = SwiftUIHostingView(rootView: DaysView(days: []))
    
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

    private lazy var aboutView: UILabel = {
        let view = UILabel()
        view.font = .size16Medium
        view.textColor = .black
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoutButton: UIButton = {
        let view = UIButton()
        view.setTitle("Log out", for: .normal)
        view.setTitleColor(.darkPinkColor, for: .normal)
        view.titleLabel?.font = .size24Medium
        view.addAction(UIAction(handler: {[weak self] _ in self?.actionHandler(.logout)}), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupContent() {
        backgroundColor = .white
        addSubview(header)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(image)
        contentView.addSubview(tagsViewBackground)
        contentView.addSubview(aboutViewBackground)
        contentView.addSubview(daysViewBackground)
        contentView.addSubview(logoutButton)
        daysViewBackground.addSubview(daysView)
        tagsViewBackground.addSubview(tagsView)
        aboutViewBackground.addSubview(aboutView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
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
            tagsViewBackground.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 60),
            tagsViewBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            tagsViewBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            tagsViewBackground.heightAnchor.constraint(equalToConstant: 100),

            // aboutView
            aboutViewBackground.topAnchor.constraint(equalTo: tagsViewBackground.bottomAnchor, constant: 20),
            aboutViewBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            aboutViewBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),

            // daysView
            daysViewBackground.topAnchor.constraint(equalTo: aboutViewBackground.bottomAnchor, constant: 20),
            daysViewBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            daysViewBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            daysViewBackground.heightAnchor.constraint(equalToConstant: 80),

            // bottom constraint to scroll
            
            logoutButton.topAnchor.constraint(equalTo: daysViewBackground.bottomAnchor, constant: 20),
            logoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            logoutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
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
