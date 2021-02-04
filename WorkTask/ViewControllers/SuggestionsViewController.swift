//
//  ViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.12.2020.
//

import UIKit

class SuggestionsViewController: UIViewController {
    //MARK: Declarations
    let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ru-RU&sort_by=popularity.desc&include_adult=true&include_video=false&page=1"
    static var films: [CurrentFilm] = []
    
    //MARK: UIElements
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .init(x: 0, y: 178, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionViewCell.self,
                    forCellWithReuseIdentifier: "CollectionViewCellReuseIdentifier")
        return cv
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let networkStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView()
        act.translatesAutoresizingMaskIntoConstraints = false
        return act
    }()
    
    
    // MARK: ViewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(label)
        setupLabel()
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(notification:)), name:NSNotification.Name(rawValue: "update"), object: nil)
        
        let coreDataManager = CoreDataManager()
        if Reachability.isConnectedToNetwork() {
            coreDataManager.deleteAllData()
            downloadFilms()
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
        }
    }
    
    //MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupCollectionView()
        setupNavigationController()
        setupActivityIndicator()
        
    }
    
    //MARK:Set up funcs -
    private func setupView() {
    view.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)

    }
    
    private func setupNavigationController() {
        tabBarController?.navigationController?.navigationBar.isHidden = true
        tabBarController?.navigationItem.searchController = nil
    }
    
    private func setupLabel() {
        label.text  = "Загрузка"
        label.textColor = .black
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.accessibilityScroll(.left)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 150)
    }
    
    private func setupNetworkStatusLabel() {
        networkStatusLabel.text = "Сеть недоступна"
        networkStatusLabel.isHidden = true
        
    }
    
    private func setupActivityIndicator() {
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    
}
