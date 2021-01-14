//
//  ViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.12.2020.
//

import UIKit


//TODO: fix navigationController bug


class ViewController: UIViewController, UICollectionViewDelegate {
//MARK: Declarations
    let colors = Colors()
    let dataManager = DataManager()
    static var films: [CurrentFilm] = []

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .init(x: 0, y: 178, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellReuseIdentifier")
        return cv
        
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let secondLabel: UILabel = {
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
    
    
// MARK: ViewDidLoad
    override func viewDidLoad() {
        
        let coreDataManager = CoreDataManager()
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(secondLabel)
        view.addSubview(collectionView)
        view.addSubview(stackView)
        view.addSubview(activityIndicator)
        
        if Reachability.isConnectedToNetwork() {
            coreDataManager.deleteAllData()
            dataManager.downloadFilms()
            NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notification:)),
                                                   name: NSNotification.Name(rawValue: "Ready to reload data"),
                                                   object: nil)
        } else {
            coreDataManager.fetchData()
            self.secondLabel.textColor = .red
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
//MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        setupStackView()
        setupLabel()
        setupCollectionView()
        setupNavigationController()
        setupActivityIndicator()
        
    }
    
    @objc func reloadData(notification: NSNotification) {
        self.collectionView.reloadData()
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.secondLabel.text = "Подборка лучших фильмов по рейтингу"
    }
    
     
    
//MARK:Set up funcs -

    private func setupNavigationController() {
        title = "Фильмы"
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(dataManager.downloadFilms))
        
    }
    
    private func setupStackView(){
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        stackView.addSubview(secondLabel)
        
    }
    
    private func setupLabel() {
        
        secondLabel.text  = "Загрузка"
        secondLabel.textColor = .black
        secondLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        secondLabel.font = .systemFont(ofSize: 16)
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.accessibilityScroll(.left)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 150) // отступ первой и последней ячейки
        
    }
    
    private func setupNetworkStatusLabel() {
        networkStatusLabel.text = "Сеть недоступна"
        networkStatusLabel.isHidden = true
        
    }
    
    private func setupActivityIndicator() {
        activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        activityIndicator.startAnimating()
    }
    
}
