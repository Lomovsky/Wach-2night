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
    static var favoriteFilms: [FavouriteFilm] = []
    

    
    func numberOfItems() -> Int {
        return FavoritesCollectionViewViewModel.favoriteFilms.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesCollectionViewCellViewModelType? {
        let film = FavoritesCollectionViewViewModel.favoriteFilms.reversed()[indexPath.row]
        return FavoritesCollectionViewCellViewModel(film: film)
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: nil, favFilm: FavoritesCollectionViewViewModel.favoriteFilms.reversed()[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
}
