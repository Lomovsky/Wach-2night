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
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ru-RU&sort_by=popularity.desc&include_adult=true&include_video=false&page=1"
    public var films: [CurrentFilm] = []
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
        print(self.films)
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
            downloadFilms()
        } else {
            print(films, "Network is not availaible")
            fetchData()
            //пофиксить баг с индикатором
            activityIndicator.stopAnimating()
            collectionView.isHidden = false
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
    
    
    
    //MARK:Set up funcs
    func registerNib() {
        let nib = UINib(nibName: CollectionViewCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 226, height: 354)
        }
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
     
        secondLabel.text  = "Подборка лучших фильмов по рейтингу"
        secondLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        secondLabel.font = .systemFont(ofSize: 16)
    }
    
    private func setupCollectionView() {
        collectionView.frame.size.width = view.frame.width
        collectionView.frame.size.height = ((view.frame.height) / 1.7)
        collectionView.backgroundColor = .white
        collectionView.accessibilityScroll(.left)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 55) // отступ первой и последней ячейки
        collectionView.isHidden = true
        
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
    
    @objc func downloadFilms() {
        
        NetworkManager.fetchCurrentData(withURL: urlString) { (result) in
            switch result {
            
            case .success(let filmResponse):
                self.filmResponse = filmResponse
                filmResponse.results.map { (film) in
                    DispatchQueue.global().async {
                        let secondPath = film.posterPath
                        let imageURLString = imagePath + secondPath
                        guard let imageURL = URL(string: imageURLString) else { return }
                        guard let posterData = try? Data(contentsOf: imageURL) else { return }
                        DispatchQueue.main.async {
                            self.save(film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating)
                            self.collectionView.reloadData()
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            self.collectionView.isHidden = false
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    
}
