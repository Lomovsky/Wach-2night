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
    let subView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let shadowSubview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(subView)
        view.addSubview(shadowSubview)
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
        
        setupActivityIndicator()
    }
    
    //MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupSubview()
        setupShadowSubview()
        setupNavigationController()
        setupCollectionView()
    }
    
    
    //MARK:Set up funcs -
    private func setupView() {
    view.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)

    }
    
    private func setupShadowSubview() {
        shadowSubview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shadowSubview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        shadowSubview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        shadowSubview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        shadowSubview.layer.shadowColor = UIColor.black.cgColor
        shadowSubview.layer.shadowRadius = 7
        shadowSubview.layer.shadowOpacity = 0.7
        shadowSubview.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
        shadowSubview.layer.masksToBounds = false
        shadowSubview.addSubview(subView)
    }
    
    private func setupSubview() {
        subView.topAnchor.constraint(equalTo: shadowSubview.topAnchor).isActive = true
        subView.leadingAnchor.constraint(equalTo: shadowSubview.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: shadowSubview.trailingAnchor).isActive = true
        subView.heightAnchor.constraint(equalTo: shadowSubview.heightAnchor).isActive = true
        subView.backgroundColor = UIColor(red: 0.96, green: 0.43, blue: 0.35, alpha: 1.00)
    }
    

    
    private func setupNavigationController() {
        tabBarController?.navigationController?.navigationBar.isHidden = false
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        tabBarController?.navigationController?.visibleViewController?.title = "Рекомендации"
        tabBarController?.navigationItem.searchController = nil
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: subView.bottomAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.accessibilityScroll(.left)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 150)
    }

        private func setupActivityIndicator() {
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    
}
