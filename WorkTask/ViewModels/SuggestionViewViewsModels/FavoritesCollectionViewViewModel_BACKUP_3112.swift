//
//  FavoriteCollectionViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

class FavoritesCollectionViewViewModel: FavoritesCollectionViewViewModelType {
    
<<<<<<< HEAD
    static var favoriteFilms: [FavouriteFilm] = []
    private var _selectedIndexPath: IndexPath?
    private let _coreDataManager = CoreDataManager()
    
    func numberOfItems() -> Int {
        return _coreDataManager.fetchFavouriteFilms()?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesCollectionViewCellViewModelType? {
        let film = FavoritesCollectionViewViewModel.favoriteFilms.reversed()[indexPath.row]
=======
    private let _coreDataManager = CoreDataManager()
    private var _selectedIndexPath: IndexPath?    

    
    func numberOfItems() -> Int {
        return _coreDataManager.fetchFavouriteFilms().count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesCollectionViewCellViewModelType? {
        let film = _coreDataManager.fetchFavouriteFilms().reversed()[indexPath.row]
>>>>>>> MVVM
        return FavoritesCollectionViewCellViewModel(film: film)
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
<<<<<<< HEAD
        return PreviewViewModel(currentFilm: nil, favFilm: FavoritesCollectionViewViewModel.favoriteFilms.reversed()[selectedIndexPath.row])
=======
        return PreviewViewModel(currentFilm: _coreDataManager.fetchFavouriteFilms().reversed()[selectedIndexPath.row], searchedFilm: nil)
>>>>>>> MVVM
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
}
