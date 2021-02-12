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


}
