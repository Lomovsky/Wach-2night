//
//  File.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 02.03.2021.
//

import UIKit

protocol SuggestionsDelegate: class {
    
    func updateFavorites()
}


extension SuggestionsViewController: SuggestionsDelegate {
    
    func updateFavorites() {
        let coreDataManager = CoreDataManager()
        coreDataManager.fetchFavouriteFilms()
        self.favouriteFilmsCollectionView.reloadData()
    }
    
    
}
