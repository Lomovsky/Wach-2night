//
//  FavoriteCollectionViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

class FavoritesCollectionViewViewModel: FavoritesCollectionViewViewModelType {
    
    private let _coreDataManager = CoreDataManager()
    private var _selectedIndexPath: IndexPath?    

    
    func numberOfItems() -> Int {
        return _coreDataManager.fetchFavouriteFilms().count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesCollectionViewCellViewModelType? {
        let film = _coreDataManager.fetchFavouriteFilms().reversed()[indexPath.row]
        return FavoritesCollectionViewCellViewModel(film: film)
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: _coreDataManager.fetchFavouriteFilms().reversed()[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
}
