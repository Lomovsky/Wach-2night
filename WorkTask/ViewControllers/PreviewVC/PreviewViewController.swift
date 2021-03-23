//
//  SecondViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 17.12.2020.
//

import UIKit

final class PreviewViewController: UIViewController {
    let coreDataManager = CoreDataManager()
    static var filmToDelete: FavouriteFilm? = nil
    static var indexOfFilmToDelete: Int? = nil
    var film: CurrentFilm? = nil
    weak var suggestionsDelegate: SuggestionsDelegate?
    
    //MARK: Declarations
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

    let containerView: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overviewText: UILabel = {
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.sizeToFit()
        return tf
    }()
    
    
    //MARK: viewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(stackView)
        view.addSubview(imageView)
        view.addSubview(favoriteButton)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(overviewText)
        
        setupView()
        setupScrollView()
        setupStackView()
        setupImageView()
        setupFavoriteButton()
        setupTitleLabel()
        setupOverviewLabel()
        setupOverviewText()
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
    }
    
    init(poster: UIImage, filmTitle: String, filmOverview: String) {
        self.imageView.image = poster
        self.titleLabel.text = filmTitle
        self.overviewText.text = filmOverview
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    deinit {
        print("PreviewVC was dealocated")
    }
    
}
