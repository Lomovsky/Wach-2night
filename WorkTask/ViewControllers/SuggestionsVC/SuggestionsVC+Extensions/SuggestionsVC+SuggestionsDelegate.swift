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
        refreshControl.endRefreshing()
        print("FINISHED UPDATING")
        //PRINTING

    }
    
    
    func updateFavorites() {
        let coreDataManager = CoreDataManager()
        coreDataManager.fetchFavouriteFilms()
        self.favouriteFilmsCollectionView.reloadData()
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
}
