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
    static var genres: [Genre] = []
    static var favouriteFilms: [FavouriteFilm] = []
    
    //MARK: UIElements
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
//        stack.spacing = 10
        return stack
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.reuseIdentifier)
        return cv
    }()
    
    let recommendationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    let favouriteFilmsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favouriteFilmsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FavouriteFilmsCollectionViewCell.self,
                    forCellWithReuseIdentifier: FavouriteFilmsCollectionViewCell.reuseIdentifier)
        return cv
    }()
    
    
    // MARK: ViewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendationsCollectionView.delegate = self
        recommendationsCollectionView.dataSource = self
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        favouriteFilmsCollectionView.delegate = self
        favouriteFilmsCollectionView.dataSource = self
        view.addSubview(scrollView)
        view.addSubview(stackView)
        view.addSubview(genreLabel)
        view.addSubview(genreCollectionView)
        view.addSubview(recommendationsLabel)
        view.addSubview(recommendationsCollectionView)
        view.addSubview(activityIndicator)
        view.addSubview(favouriteFilmsLabel)
        view.addSubview(favouriteFilmsCollectionView)

        setupView()
        setupScrollView()
        setupStackView()
        setupGenreLabel()
        setupGenerCollectionView()
        setupRecommendationsLabel()
        setupRecommendationsCollectionView()
        setupActivityIndicator()
        setupFavouriteFilmsLabel()
        setupFavouritesCollectionView()
        
        let coreDataManager = CoreDataManager()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(notification:)), name:NSNotification.Name(rawValue: "update"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavouriteCollectionView(notification:)), name: NSNotification.Name(rawValue: "update favourite collectionView"), object: nil)
        
        if Reachability.isConnectedToNetwork() {
            coreDataManager.deleteAllData()
            coreDataManager.fetchFavouriteFilms()
            downloadFilms()
            downloadGenres()
            
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
        view.backgroundColor = .white

    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.visibleViewController?.title = "Главная"
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        navigationItem.searchController = nil
    }
    
    private func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.addSubview(stackView)
    }
    
    private func setupStackView() {
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(genreCollectionView)
        stackView.addArrangedSubview(recommendationsLabel)
        stackView.addArrangedSubview(recommendationsCollectionView)
        stackView.addArrangedSubview(favouriteFilmsLabel)
        stackView.addArrangedSubview(favouriteFilmsCollectionView)
    }
    
    private func setupGenreLabel() {
        genreLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 5).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 17).isActive = true
        genreLabel.text = "Жанры"
        genreLabel.font = .boldSystemFont(ofSize: 20)
    }
 
       
    private func setupGenerCollectionView() {
        genreCollectionView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 5).isActive = true
        genreCollectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        genreCollectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        genreCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        genreCollectionView.backgroundColor = .clear
        genreCollectionView.accessibilityScroll(.left)
        genreCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
    }
    
    private func setupRecommendationsLabel() {
        recommendationsLabel.topAnchor.constraint(equalTo: genreCollectionView.bottomAnchor, constant: 5).isActive = true
        recommendationsLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 17).isActive = true
        recommendationsLabel.text = "Рекомендуем к просмотру"
        recommendationsLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func setupRecommendationsCollectionView() {
        recommendationsCollectionView.topAnchor.constraint(equalTo: recommendationsLabel.bottomAnchor, constant: 20).isActive = true
        recommendationsCollectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        recommendationsCollectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        recommendationsCollectionView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.41).isActive = true
        recommendationsCollectionView.accessibilityScroll(.left)
        recommendationsCollectionView.backgroundColor = .clear
        recommendationsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
    }

        private func setupActivityIndicator() {
        activityIndicator.centerYAnchor.constraint(equalTo: recommendationsCollectionView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: recommendationsCollectionView.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    private func setupFavouriteFilmsLabel() {
        favouriteFilmsLabel.topAnchor.constraint(equalTo: recommendationsCollectionView.bottomAnchor, constant: 5).isActive = true
        favouriteFilmsLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 17).isActive = true
        favouriteFilmsLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        favouriteFilmsLabel.frame.size.height = recommendationsLabel.frame.height
        favouriteFilmsLabel.text = "Избранное"
        favouriteFilmsLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func setupFavouritesCollectionView() {
        favouriteFilmsCollectionView.topAnchor.constraint(equalTo: favouriteFilmsLabel.bottomAnchor, constant: 5).isActive = true
        favouriteFilmsCollectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        favouriteFilmsCollectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        favouriteFilmsCollectionView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.41).isActive = true
        favouriteFilmsCollectionView.backgroundColor = .clear
        favouriteFilmsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
    }
}
