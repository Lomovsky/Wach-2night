//
//  ViewControllerHelperFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 15.01.2021.
//

import UIKit

extension SuggestionsViewController {
    
    func checkConnection() {
        let coreDataManager = CoreDataManager()
        if Reachability.isConnectedToNetwork() {
            coreDataManager.deleteAllData()
            SuggestionsViewController.films.removeAll()
            SuggestionsViewController.genres.removeAll()
            coreDataManager.fetchFavouriteFilms()
            DataManager.downloadFilms()
            DataManager.downloadGenres()
            
        } else {
            coreDataManager.fetchFilmsData()
            coreDataManager.fetchGenresData()
            coreDataManager.fetchFavouriteFilms()
            DispatchQueue.main.async {
                self.recommendationsCollectionView.reloadData()
                self.recommendationsCollectionView.isHidden = false
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.genreCollectionView.reloadData()
                self.favouriteFilmsCollectionView.reloadData()
                self.recommendationsCollectionView.reloadData()
            }
            
        }
    }
    
    @objc final func showSearch() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc final func refresh(_ sender: AnyObject) {
        checkConnection()
    }
    
    func animateCell(cell: UICollectionViewCell) {
        
        UIView.animate(withDuration: 0.2,
                       animations: {
                        //Fade-out
                        cell.alpha = 0.5
                       }) { (completed) in
            UIView.animate(withDuration: 0.2,
                           animations: {
                            //Fade-out
                            cell.alpha = 1
                           })
        }
    }
    
    
}


