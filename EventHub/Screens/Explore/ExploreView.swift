//
//  ExploreView.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 19.11.2024.
//

import UIKit

protocol CreateLayoutDelegate: AnyObject {
    func createLayout() -> UICollectionViewCompositionalLayout
}

final class ExploreView: UIView {
    
    // MARK: - Properties
    weak var delegate: CreateLayoutDelegate?
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .PrimaryBlue
        view.layer.cornerRadius = 30
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let currentLocationButton: UIButton = {
        let button = UIButton(type: .system)
        let title = "Current Location"
        let icon = UIImage(named: "arrowtriangle")?.withRenderingMode(.alwaysTemplate)
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.image = icon
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.baseForegroundColor = .ShadowBlue
        configuration.baseBackgroundColor = .clear
        configuration.imageColorTransformer = UIConfigurationColorTransformer { _ in
                .white
        }
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView = UITableView()
    private let transparentView = UIView()
    
    private let bellButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "bell.badge")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .LightBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
//    SearchBar
    private let searchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.searchWhite
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let searchBar: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Search..."
        textField.tintColor = .shadowBlue
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
#warning("message: Внести правки в код")  // MARK: - Внести правки в код!!!!!
    let dataSource = ["Sport", "Music", "Food", "Party", "Kids"]

    private lazy var filterButton: UIButton = {
        let button = UIButton(primaryAction: nil)
        var menuChildren: [UIMenuElement] = []
        for item in dataSource {
            menuChildren.append(UIAction(title: item, handler: actionClosure))
        }
        button.menu = UIMenu(options: .displayInline, children: menuChildren)
        var configuration = UIButton.Configuration.bordered()
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = false
        configuration.image = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")
        configuration.title = "Filter"
        configuration.imagePlacement = .leading
        configuration.contentInsets.leading = 5
        configuration.imagePadding = 5
        button.tintColor = .white
        button.backgroundColor = .LightBlue
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let actionClosure = { (action:UIAction) in
        print((action.title))
    }
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .BackgroundGray
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
        tapedButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func tapedButton(_ sender: UIButton) {
        print("Taped \(sender.currentTitle ?? "bell")")
        showTableView(frames: sender.frame)
    }
    
    @objc func hideTableView() {
        tableView.isHidden = true
        transparentView.isHidden = true
    }
    
    // MARK: - Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        filterButton.layer.cornerRadius = filterButton.bounds.height / 2
        bellButton.layer.cornerRadius = bellButton.bounds.height / 2
    }
    
    private func tapedButtons() {
        //        bellButton.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        currentLocationButton.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
    }
    
    func addTableView(frames: CGRect) {
        transparentView.backgroundColor = UIColor.clear
        transparentView.frame = self.frame
        self.addSubview(transparentView)
        
        tableView.rowHeight = 40
        let tableVeiwHeight = 120.0
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: CGFloat(tableVeiwHeight))
        self.addSubview(tableView)
        
        tableView.layer.cornerRadius = 5
        tableView.separatorStyle = .none
        tableView.tintColor = .blue
        tableView.layer.borderWidth = 0
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(hideTableView))
        transparentView.addGestureRecognizer(tapgesture)
        
        tableView.isHidden = false
        transparentView.isHidden = false
    }
    
    func showTableView(frames: CGRect) {
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: 100, height: tableView.frame.height)
        tableView.isHidden = false
    }
    
    private func setViews() {
        backgroundColor = .BackgroundGray
        let backgroundView = UIView()
        backgroundView.backgroundColor = backgroundColor
        [
            mainView,
            collectionView,
            categoryCollectionView
        ].forEach {addSubview($0)}
        
        [
            searchImage,
            searchBar,
            filterButton,
            currentLocationButton,
            bellButton
        ].forEach {mainView.addSubview($0)}
        
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "EventCell")
        collectionView.register(NearbyCollectionViewCell.self, forCellWithReuseIdentifier: "NearbyCell")
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCell")
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        addTableView(frames: currentLocationButton.frame)
    }
    
    func setDelegates(_ value: ExploreViewController) {
        delegate = value
        collectionView.delegate = value
        collectionView.dataSource = value
        categoryCollectionView.delegate = value
        categoryCollectionView.dataSource = value
        tableView.delegate = value
        tableView.dataSource = value
        //        после делегата!!! а то будет nil
        if let layout = delegate?.createLayout() {
            collectionView.collectionViewLayout = layout
        }
    }
}

// MARK: - Extensions SetConstraints
extension ExploreView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.22),
            
            searchImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            searchImage.widthAnchor.constraint(equalToConstant: 24),
            searchImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 110),
            
            searchBar.centerYAnchor.constraint(equalTo: searchImage.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 10),
            searchBar.widthAnchor.constraint(lessThanOrEqualTo: mainView.widthAnchor, multiplier: 0.5),
            
            filterButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 10),
            filterButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            filterButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            filterButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 32),
            
            currentLocationButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            currentLocationButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            
            bellButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            bellButton.centerYAnchor.constraint(equalTo: currentLocationButton.centerYAnchor),
            bellButton.heightAnchor.constraint(equalToConstant: 36),
            bellButton.widthAnchor.constraint(equalToConstant: 36),
            
            categoryCollectionView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -30),
            categoryCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
