//
//  FavoriteCollectionViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

class FavoritesCollectionViewViewModel: FavoritesCollectionViewViewModelType {
    
    private var _selectedIndexPath: IndexPath?
    private let coreDataManager = CoreDataManager()
    
    func numberOfItems() -> Int {
        coreDataManager.fetchFavouriteFilms()?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesCollectionViewCellViewModelType? {
        guard let film = coreDataManager.fetchFavouriteFilms()?[indexPath.row] else { return nil }
        return FavoritesCollectionViewCellViewModel(film: film)
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: nil, favFilm: coreDataManager.fetchFavouriteFilms()?[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
}
