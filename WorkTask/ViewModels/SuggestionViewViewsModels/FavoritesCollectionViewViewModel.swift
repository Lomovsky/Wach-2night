//
//  FavoriteCollectionViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

class FavoritesCollectionViewViewModel: FavoritesCollectionViewViewModelType {
    
    private let coreDataManager = CoreDataManager()
    
    func numberOfItems() -> Int {
        CoreDataManager.favouriteFilms.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesCollectionViewCellViewModelType? {
        let film = CoreDataManager.favouriteFilms[indexPath.row]
        return FavoritesCollectionViewCellViewModel(film: film)
    }
    
}
