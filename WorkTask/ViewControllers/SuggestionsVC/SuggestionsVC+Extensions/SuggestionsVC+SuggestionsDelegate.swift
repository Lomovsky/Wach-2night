//
//  SuggestionsVC+SuggestionsDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.03.2021.
//

import UIKit

extension SuggestionsViewController: SuggestionsDelegate {
      
    func uppateUIAfterDownloadingData() {
        genreCollectionView.reloadData()
        genreCollectionView.isHidden = false
        recommendationsCollectionView.reloadData()
        recommendationsCollectionView.isHidden = false
        favouriteFilmsCollectionView.reloadData()
        favouriteFilmsCollectionView.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true

    }
    
    func updateGenresUI() {
        genreCollectionView.reloadData()
        genreCollectionView.isHidden = false
    }
    
    
    func updateFavorites() {
        favouriteFilmsCollectionView.reloadData()
        favouriteFilmsCollectionView.reloadData()
        print(favouriteFilmsCollectionView.numberOfItems(inSection: 0))
    }
    
    func updateUIOffline() {
        recommendationsCollectionView.reloadData()
        recommendationsCollectionView.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        genreCollectionView.reloadData()
        favouriteFilmsCollectionView.reloadData()
        recommendationsCollectionView.reloadData()
    }
    
    func stopRefreshing() {
        refreshControl.endRefreshing()
        view.layoutSubviews()
    }
}
