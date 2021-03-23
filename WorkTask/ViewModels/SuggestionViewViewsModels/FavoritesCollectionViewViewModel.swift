//
//  FavoriteCollectionViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

class FavoritesCollectionViewViewModel: FavoritesCollectionViewViewModelType {
    
    private var _selectedIndexPath: IndexPath?
    
    func numberOfItems() -> Int {
        CoreDataManager.favouriteFilms.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesCollectionViewCellViewModelType? {
        let film = CoreDataManager.favouriteFilms.reversed()[indexPath.row]
        return FavoritesCollectionViewCellViewModel(film: film)
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: nil, favFilm: CoreDataManager.favouriteFilms[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
}
