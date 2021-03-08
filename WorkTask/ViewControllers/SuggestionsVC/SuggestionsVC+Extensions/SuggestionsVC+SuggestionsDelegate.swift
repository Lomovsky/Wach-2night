//
//  SuggestionsVC+SuggestionsDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.03.2021.
//

import UIKit

extension SuggestionsViewController: SuggestionsDelegate {
    
    func updateFavorites() {
        let coreDataManager = CoreDataManager()
        coreDataManager.fetchFavouriteFilms()
        self.favouriteFilmsCollectionView.reloadData()
    }
}
