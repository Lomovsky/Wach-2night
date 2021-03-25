//
//  SuggestionsVC+UIFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.02.2021.
//

import UIKit

extension SuggestionsViewController {
    //MARK: UIFuncs -
    func setupRefreshControll() {
        refreshControl.attributedTitle = NSAttributedString(string: "Потяните для обновления")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
    }
    
    
    func setupView() {
        view.backgroundColor = .white
        
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.visibleViewController?.title = "Главная"
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        navigationItem.searchController = nil
    }
    
    func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.refreshControl = refreshControl
        scrollView.addSubview(contentView)
    }
    
    func setupContentView() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor).isActive = true
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: 250)
        heightConstraint.isActive = true
        contentView.addSubview(genreLabel)
        contentView.addSubview(genreCollectionView)
        contentView.addSubview(recommendationsLabel)
        contentView.addSubview(recommendationsStack)
        contentView.addSubview(favouriteFilmsLabel)
        contentView.addSubview(favouriteFilmsCollectionView)
    }

    func setupGenreLabel() {
        genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17).isActive = true
        genreLabel.text = "Жанры"
        genreLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    
    func setupGenerCollectionView() {
        genreCollectionView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 5).isActive = true
        genreCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        genreCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        genreCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        genreCollectionView.backgroundColor = .clear
        genreCollectionView.accessibilityScroll(.left)
        genreCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
    }
    
    func setupRecommendationsLabel() {
        recommendationsLabel.topAnchor.constraint(equalTo: genreCollectionView.bottomAnchor, constant: 5).isActive = true
        recommendationsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17).isActive = true
        recommendationsLabel.text = "Рекомендуем к просмотру"
        recommendationsLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    func setupRecommendationsStack() {
        recommendationsStack.topAnchor.constraint(equalTo: recommendationsLabel.bottomAnchor, constant: 5).isActive = true
        recommendationsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recommendationsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        recommendationsStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.41).isActive = true
        recommendationsStack.addSubview(recommendationsCollectionView)
        recommendationsStack.addSubview(activityIndicator)
        
    }

    func setupRecommendationsCollectionView() {
        recommendationsCollectionView.topAnchor.constraint(equalTo: recommendationsStack.topAnchor).isActive = true
        recommendationsCollectionView.leadingAnchor.constraint(equalTo: recommendationsStack.leadingAnchor).isActive = true
        recommendationsCollectionView.trailingAnchor.constraint(equalTo: recommendationsStack.trailingAnchor).isActive = true
        recommendationsCollectionView.bottomAnchor.constraint(equalTo: recommendationsStack.bottomAnchor).isActive = true
        recommendationsCollectionView.accessibilityScroll(.left)
        recommendationsCollectionView.backgroundColor = .clear
        recommendationsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
    }
    
    func setupActivityIndicator() {
        activityIndicator.centerYAnchor.constraint(equalTo: recommendationsStack.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: recommendationsStack.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    func setupFavouriteFilmsLabel() {
        favouriteFilmsLabel.topAnchor.constraint(equalTo: recommendationsStack.bottomAnchor, constant: 5).isActive = true
        favouriteFilmsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17).isActive = true
        favouriteFilmsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        favouriteFilmsLabel.frame.size.height = recommendationsLabel.frame.height
        favouriteFilmsLabel.text = "Избранное"
        favouriteFilmsLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    func setupFavouritesCollectionView() {
        favouriteFilmsCollectionView.topAnchor.constraint(equalTo: favouriteFilmsLabel.bottomAnchor, constant: 5).isActive = true
        favouriteFilmsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        favouriteFilmsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        favouriteFilmsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        favouriteFilmsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.41).isActive = true
        favouriteFilmsCollectionView.backgroundColor = .clear
        favouriteFilmsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
    }
    
}
