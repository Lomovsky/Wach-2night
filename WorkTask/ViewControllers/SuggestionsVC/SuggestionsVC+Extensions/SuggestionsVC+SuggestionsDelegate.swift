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
        recommendationsCollectionView.reloadData()
        recommendationsCollectionView.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        refreshControl.endRefreshing()
    }
    
    
    func updateFavorites() {
        let coreDataManager = CoreDataManager()
        coreDataManager.fetchFavouriteFilms()
        self.favouriteFilmsCollectionView.reloadData()
    }
}
