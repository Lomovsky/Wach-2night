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
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.refreshControl = refreshControl
        scrollView.addSubview(stackView)
    }
    
    func setupStackView() {
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
    
    func setupGenreLabel() {
        genreLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 5).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 17).isActive = true
        genreLabel.text = "Жанры"
        genreLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    
    func setupGenerCollectionView() {
        genreCollectionView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 5).isActive = true
        genreCollectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        genreCollectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        genreCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        genreCollectionView.backgroundColor = .clear
        genreCollectionView.accessibilityScroll(.left)
        genreCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
    }
    
    func setupRecommendationsLabel() {
        recommendationsLabel.topAnchor.constraint(equalTo: genreCollectionView.bottomAnchor, constant: 5).isActive = true
        recommendationsLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 17).isActive = true
        recommendationsLabel.text = "Рекомендуем к просмотру"
        recommendationsLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    func setupRecommendationsCollectionView() {
        recommendationsCollectionView.topAnchor.constraint(equalTo: recommendationsLabel.bottomAnchor, constant: 20).isActive = true
        recommendationsCollectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        recommendationsCollectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        recommendationsCollectionView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.41).isActive = true
        recommendationsCollectionView.accessibilityScroll(.left)
        recommendationsCollectionView.backgroundColor = .clear
        recommendationsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
    }
    
    func setupActivityIndicator() {
        activityIndicator.centerYAnchor.constraint(equalTo: recommendationsCollectionView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: recommendationsCollectionView.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    func setupFavouriteFilmsLabel() {
        favouriteFilmsLabel.topAnchor.constraint(equalTo: recommendationsCollectionView.bottomAnchor, constant: 5).isActive = true
        favouriteFilmsLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 17).isActive = true
        favouriteFilmsLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        favouriteFilmsLabel.frame.size.height = recommendationsLabel.frame.height
        favouriteFilmsLabel.text = "Избранное"
        favouriteFilmsLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    func setupFavouritesCollectionView() {
        favouriteFilmsCollectionView.topAnchor.constraint(equalTo: favouriteFilmsLabel.bottomAnchor, constant: 5).isActive = true
        favouriteFilmsCollectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        favouriteFilmsCollectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        favouriteFilmsCollectionView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.41).isActive = true
        favouriteFilmsCollectionView.backgroundColor = .clear
        favouriteFilmsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
    }
    
}
