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
    var film: Film? = nil
    

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

        let coreDataManager = CoreDataManager()
        if Reachability.isConnectedToNetwork() {
            coreDataManager.deleteAllData()
            downloadFilms()
            
        } else {
            coreDataManager.fetchData()
            self.label.textColor = .red
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
//MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        setupLabel()
        setupCollectionView()
        setupNavigationController()
        setupActivityIndicator()
        setGradientBackground()
        
    }
    
//MARK:Set up funcs -  
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 0.95, green: 0.98, blue: 0.93, alpha: 1.00).cgColor
        let colorBottom = UIColor(red: 0.68, green: 0.76, blue: 0.81, alpha: 1.00).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupLabel() {
        
        label.text  = "Загрузка"
        label.textColor = .black
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.font = .systemFont(ofSize: 16, weight: .bold)
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
        activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        activityIndicator.startAnimating()
    }
    
    
}
