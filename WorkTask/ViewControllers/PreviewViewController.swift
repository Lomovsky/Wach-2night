//
//  SecondViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 17.12.2020.
//

import UIKit

class PreviewViewController: UIViewController {
    var film: CurrentFilm? = nil
    
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
        stack.spacing = 10
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
//        view.addSubview(containerView)
        view.addSubview(imageView)
        view.addSubview(favoriteButton)
        view.addSubview(titleLabel)
        view.addSubview(overviewText)
        
        
        setupView()
        setupScrollView()
        setupStackView()
//        setupContainerView()
        setupImageView()
        setupFavoriteButton()
        setupTitleLabel()
        setupOverviewLabel()
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    
    //MARK: Setup Funcs
    @objc func buttonPressed() {
        let coreDataManager = CoreDataManager()
        coreDataManager.saveFavouriteFilm(film!.title!, filmOriginalTitle: film!.originalTitle!, filmRating: film!.rating, filmOverview: film!.overview!, filmPoster: film!.poster!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update favourite collectionView"), object: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    
    private func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.addSubview(stackView)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupStackView() {
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(favoriteButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(overviewText)
    }

//    private func setupContainerView() {
//        containerView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
//        containerView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
//        containerView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
//        containerView.addSubview(imageView)
//        containerView.layer.shadowColor = UIColor.black.cgColor
//        containerView.layer.shadowRadius = 7
//        containerView.layer.shadowOpacity = 0.7
//        containerView.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
//        containerView.layer.masksToBounds = false
//    }

    private func setupImageView() {
        imageView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        imageView.frame.size.height = imageView.image!.accessibilityFrame.height
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

    }
    
    private func setupFavoriteButton() {
        favoriteButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        favoriteButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        favoriteButton.setTitle("Добавить в избранное", for: .normal)
        favoriteButton.backgroundColor = .systemGreen
        favoriteButton.titleLabel?.textColor = .white
        favoriteButton.layer.cornerRadius = 10
        favoriteButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    }
    
    private func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.numberOfLines = 0
        titleLabel.frame.size.height = 49
    }
    
    private func setupOverviewLabel() {
        overviewText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        overviewText.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        overviewText.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5).isActive = true
        overviewText.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        overviewText.numberOfLines = 0
        
        
    }

    
    deinit {
        print("PreviewVC was dealocated")
    }
    
}
