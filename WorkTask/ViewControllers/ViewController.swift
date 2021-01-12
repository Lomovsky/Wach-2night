//
//  ViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.12.2020.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    //MARK: Declarations
    let secondVC = SecondViewController()
    let colors = Colors()
    let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ru-RU&sort_by=popularity.desc&include_adult=true&include_video=false&page=1"
    static var films: [CurrentFilm] = []
    var filmResponse: FilmResponse? = nil
    
    
    //MARK: Setting up UI elements
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
        print(ViewController.films)
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(secondLabel)
        view.addSubview(collectionView)
        view.addSubview(stackView)
        view.addSubview(activityIndicator)
        registerNib()
        
        
        if Reachability.isConnectedToNetwork() {
            self.activityIndicator.isHidden = false
            coreDataManager.deleteAllData()
            downloadFilms()
            
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
        setupView()
        
    }
    
    
    @objc func downloadFilms() {
        let coreDataManager = CoreDataManager()
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        NetworkManager.fetchCurrentData(withURL: urlString) { [weak self ](result) in
            guard let self = self else { return }
            switch result {
            
            case .success(let filmResponse):
                self.filmResponse = filmResponse
                filmResponse.results.map { (film) in
                    DispatchQueue.global().async {
                        let secondPath = film.posterPath
                        let imageURLString = imagePath + secondPath
                        guard let imageURL = URL(string: imageURLString) else { return }
                        guard let posterData = try? Data(contentsOf: imageURL) else { return }
                        let posterImage = UIImage(data: posterData)
                        ImageResizer.resizeImage(image: posterImage!, targetSize: CGSize.init(width: 300, height: 445)) { [weak self]
                            (newPoster)  in
                            guard let self = self else { return }
                            let newPosterData = newPoster.pngData()
                            DispatchQueue.main.async {
                                coreDataManager.save(film.title, filmOriginalTitle: film.originalTitle, filmPoster: newPosterData!, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating, originalPoster: posterData)
                                self.collectionView.reloadData()
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.isHidden = true
                                self.secondLabel.text = "Подборка лучших фильмов по рейтингу"
                            }
                        }

                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    
    
    
    //MARK:Set up funcs
    func registerNib() {
        let nib = UINib(nibName: CollectionViewCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 226, height: 354)
        }
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer!.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    private func setupNavigationController() {
        title = "Фильмы"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(downloadFilms))

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
        collectionView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 30).isActive = true
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
