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
    
    let stackView: UIStackView = {  // обьединяем labels
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let movieLabel: UILabel = { // первый label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondLabel: UILabel = { // второй label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        print(self.films)
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(movieLabel)
        view.addSubview(secondLabel)
        view.addSubview(collectionView)
        view.addSubview(stackView)
        registerNib()
        NetworkManager.fetchCurrentData(withURL: urlString) { (result) in
            switch result {
            
            case .success(let filmResponse):
                self.filmResponse = filmResponse
                filmResponse.results.map { (film) in
                    DispatchQueue.global().async {
                        let secondPath = film.posterPath
                        let imageURLString = imagePath + secondPath
                        guard let imageURL = URL(string: imageURLString) else { return }
                        guard let imageData = try? Data(contentsOf: imageURL) else { return }
                        DispatchQueue.main.async {
                            self.save(film.title, filmOriginalTitle: film.originalTitle, filmPoster: imageData)
                            self.collectionView.reloadData()
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        setupStackView()
        setupLabels()
        setupCollectionView()
        
        
    }
    
    //MARK:Set up funcs
    func registerNib() {
        let nib = UINib(nibName: CollectionViewCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 226, height: 354)
        }
    }
    
    private func setupStackView(){
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36.0).isActive = true
        stackView.addSubview(movieLabel)
        stackView.addSubview(secondLabel)
        
    }
    
    private func setupLabels() {
        movieLabel.text = "Movies"//настройка  первого лейбла
        movieLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0).isActive = true
        movieLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36.0).isActive = true
        movieLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        movieLabel.font = .systemFont(ofSize: 32)
        
        secondLabel.text  = "The library of my favourite movies"
        secondLabel.topAnchor.constraint(equalTo: movieLabel.topAnchor, constant: 60).isActive = true
        secondLabel.font = .systemFont(ofSize: 16)
    }
    
    private func setupCollectionView() {
        collectionView.frame.size.width = view.frame.width
        collectionView.frame.size.height = ((view.frame.height) / 0.5)
        collectionView.backgroundColor = .white
        collectionView.accessibilityScroll(.left)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 55) // отступ первой и последней ячейки
        
    }
    
    
}
