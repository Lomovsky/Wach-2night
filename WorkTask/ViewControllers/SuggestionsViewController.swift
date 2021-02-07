//
//  ViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.12.2020.
//

import UIKit
class SuggestionsViewController: UIViewController {
    //MARK: Declarations
    static var films: [CurrentFilm] = []
    let genres = ["Фентези", "Триллер", "Ужасы", "Мелодрама"]
    
    //MARK: UIElements
    let topSubviewShadow: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topSubView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    let genreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.reuseIdentifier)
        return cv
    }()
    
    let recommendationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .init(x: 0, y: 178, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(RecommendationsCollectionViewCell.self,
                    forCellWithReuseIdentifier: RecommendationsCollectionViewCell.reuseIdentifier)
        return cv
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView()
        act.translatesAutoresizingMaskIntoConstraints = false
        return act
    }()
    
    
    // MARK: ViewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendationsCollectionView.delegate = self
        recommendationsCollectionView.dataSource = self
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        view.addSubview(topSubView)
        view.addSubview(topSubviewShadow)
        view.addSubview(genreCollectionView)
        view.addSubview(recommendationsCollectionView)
        view.addSubview(activityIndicator)

        setupView()
        setupTopSubview()
        setupTopSubviewShadow()
        setupGenerCollectionView()
        setupRecommendationsCollectionView()
        setupActivityIndicator()
        
        let coreDataManager = CoreDataManager()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(notification:)), name:NSNotification.Name(rawValue: "update"), object: nil)
        if Reachability.isConnectedToNetwork() {
            coreDataManager.deleteAllData()
            downloadFilms()
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
        }
    }
    
    //MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }
    
    
    //MARK:Set up funcs -
    private func setupView() {
    view.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)

    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.visibleViewController?.title = "Рекомендации"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        navigationItem.searchController = nil
    }
    
    private func setupTopSubviewShadow() {
        topSubviewShadow.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topSubviewShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topSubviewShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topSubviewShadow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.27).isActive = true
        topSubviewShadow.layer.shadowColor = UIColor.black.cgColor
        topSubviewShadow.layer.shadowRadius = 7
        topSubviewShadow.layer.shadowOpacity = 0.7
        topSubviewShadow.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
        topSubviewShadow.layer.masksToBounds = false
        topSubviewShadow.addSubview(topSubView)
    }
    
    private func setupTopSubview() {
        topSubView.topAnchor.constraint(equalTo: topSubviewShadow.topAnchor).isActive = true
        topSubView.leadingAnchor.constraint(equalTo: topSubviewShadow.leadingAnchor).isActive = true
        topSubView.trailingAnchor.constraint(equalTo: topSubviewShadow.trailingAnchor).isActive = true
        topSubView.heightAnchor.constraint(equalTo: topSubviewShadow.heightAnchor).isActive = true
        topSubView.backgroundColor = UIColor(red: 0.96, green: 0.43, blue: 0.35, alpha: 1.00)
        topSubView.addSubview(genreCollectionView)
    }
       
    private func setupGenerCollectionView() {
        genreCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        genreCollectionView.leadingAnchor.constraint(equalTo: topSubView.leadingAnchor).isActive = true
        genreCollectionView.trailingAnchor.constraint(equalTo: topSubView.trailingAnchor).isActive = true
        genreCollectionView.bottomAnchor.constraint(equalTo: topSubView.bottomAnchor).isActive = true
        genreCollectionView.backgroundColor = .clear
        genreCollectionView.accessibilityScroll(.left)
        genreCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
    }
    
    private func setupRecommendationsCollectionView() {
        recommendationsCollectionView.topAnchor.constraint(equalTo: topSubView.bottomAnchor, constant: 20).isActive = true
        recommendationsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recommendationsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recommendationsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        recommendationsCollectionView.accessibilityScroll(.left)
        recommendationsCollectionView.backgroundColor = .clear
        recommendationsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
    }

        private func setupActivityIndicator() {
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
}
