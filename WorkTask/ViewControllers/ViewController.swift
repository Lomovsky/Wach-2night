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
    lazy var refreshControl = UIRefreshControl()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .init(x: 0, y: 178, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellReuseIdentifier")
        return cv
        
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
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
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(scrollView)
        checkConnection()

    }
    
    
//MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        setupLabel()
        setupCollectionView()
        setupNavigationController()
        setupActivityIndicator()
        setupScrollView()
        
    }

     
    
//MARK:Set up funcs -

    private func setupNavigationController() {
        title = "Фильмы"
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        //postponed due to wrong logics of updating collectionView -> fatalError
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
//                                                            target: self,
//                                                            action: #selector(checkConnection))
        
    }
    
    
    private func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        scrollView.addSubview(collectionView)
        scrollView.refreshControl = refreshControl
        scrollView.addSubview(label)
        scrollView.addSubview(activityIndicator)
    }
    
    private func setupLabel() {
        
        label.text  = "Загрузка"
        label.textColor = .black
        label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        label.font = .systemFont(ofSize: 16)
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
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
    
    
// MARK: Helper funcs -
    
    @objc func checkConnection() {
        let coreDataManager = CoreDataManager()
        if Reachability.isConnectedToNetwork() {
            
            dataManager.downloadFilms()
            NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notification:)),
                                                   name: NSNotification.Name(rawValue: "Ready to reload data"),
                                                   object: nil)
            
        } else {
            coreDataManager.fetchData()
            self.label.textColor = .red
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func reloadData(notification: NSNotification) {
        self.collectionView.reloadData()
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.label.text = "Подборка лучших фильмов по рейтингу"
    }
    
    @objc func refresh(_ sender: AnyObject) {
        checkConnection()
        refreshControl.endRefreshing()
    }
    

}
