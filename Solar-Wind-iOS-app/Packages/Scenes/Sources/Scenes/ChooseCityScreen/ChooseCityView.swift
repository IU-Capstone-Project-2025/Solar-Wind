//
//  ChooseCityView.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit
import CommonUI

class ChooseCityView: View {
    private typealias DataSource = UITableViewDiffableDataSource<ChooseCity.RootViewModel.Section, ChooseCity.City>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ChooseCity.RootViewModel.Section, ChooseCity.City>
    
    var viewModel: ChooseCity.RootViewModel? {
        didSet {
            var snapshot = Snapshot()
            guard let viewModel = viewModel else { return }
            snapshot.appendSections(viewModel.sections)
            viewModel.sections.forEach { section in
                switch section {
                case .items(let items):
                    snapshot.appendItems(items, toSection: section)
                }
            }
            dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    func setSelectedCity(_ city: ChooseCity.City) {
        searchView.setText(city.name)
    }

    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        view.separatorStyle = .none
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.rowHeight = UITableView.automaticDimension
        view.backgroundColor = .white
        view.separatorStyle = .singleLine
        view.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.separatorColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let button = GradientButton()
        button.title = "Continue"
        button.addAction(
            UIAction(
                handler: { [weak self] _ in
                    self?.actionHandler(.next)
                }),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(
            tableView: tableView
        ) { tableView, indexPath, item in
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
                cell.viewModel = .init(city: item)
                cell.selectionStyle = .none
                return cell
            default:
                break
            }
            return UITableViewCell()
        }
        return dataSource
    }()
    
    enum Action {
        case next
        case selected(Int)
        case add
        case back
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    private lazy var header = addGradientHeader(backButton: false)
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Choose your city"
        view.textColor = .black
        view.font = .size24Medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchView: SearchView = {
        let view = SearchView(placeholder: "Search...")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupContent() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(searchView)
        addSubview(tableView)
        addSubview(nextButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            searchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchView.heightAnchor.constraint(equalToConstant: 45),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 6),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 6),
            
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}

extension ChooseCityView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionHandler(.selected(indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let itemsCount = viewModel?.currentItemsCount else { return }
        if indexPath.row == itemsCount - 5 {
            self.actionHandler(.add)
        }
    }
}

class SearchCell: UITableViewCell {

    var actionHandler: (SearchCellContentView.Action) -> Void {
        get {
            content.actionHandler
        }
        set {
            content.actionHandler = newValue
        }
    }

    var viewModel: SearchCellContentView.Model? {
        get {
            content.viewModel
        }
        set {
            content.viewModel = newValue ?? .init(
                city: .init(id: -1, name: "")
            )
        }
    }

    private lazy var content: SearchCellContentView = {
        let view = SearchCellContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        view.pinToSuperview()
        return view
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
}

class SearchCellContentView: View {
    public struct Model {
        let city: String
        
        public init(city: ChooseCity.City) {
            self.city = city.name
        }
    }
    
    public var viewModel: Model = .init(city: ChooseCity.City(id: -1, name: "")) {
        didSet {
            cityLabel.text = viewModel.city
        }
    }
    
    public enum Action {
        case pressed
    }
    public var actionHandler: (Action) -> Void = { _ in }
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .size16Medium
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupContent() {
        super.setupContent()
        addSubview(cityLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            cityLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

