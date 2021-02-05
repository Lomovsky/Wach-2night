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
        recommendationsCollectionView.delegate = self
        recommendationsCollectionView.dataSource = self
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        view.addSubview(subView)
        view.addSubview(shadowSubview)
        view.addSubview(genreCollectionView)
        view.addSubview(recommendationsCollectionView)
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
        setupGenerCollectionView()
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
        shadowSubview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.27).isActive = true
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
        subView.addSubview(genreCollectionView)
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
    
    private func setupGenerCollectionView() {
        genreCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        genreCollectionView.leadingAnchor.constraint(equalTo: subView.leadingAnchor).isActive = true
        genreCollectionView.trailingAnchor.constraint(equalTo: subView.trailingAnchor).isActive = true
        genreCollectionView.bottomAnchor.constraint(equalTo: subView.bottomAnchor).isActive = true
        genreCollectionView.backgroundColor = .clear
        genreCollectionView.accessibilityScroll(.left)
        genreCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    private func setupCollectionView() {
        recommendationsCollectionView.topAnchor.constraint(equalTo: subView.bottomAnchor, constant: 20).isActive = true
        recommendationsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recommendationsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recommendationsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        recommendationsCollectionView.accessibilityScroll(.left)
        recommendationsCollectionView.backgroundColor = .clear
        recommendationsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 150)
    }

        private func setupActivityIndicator() {
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    @objc func showSearch() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
