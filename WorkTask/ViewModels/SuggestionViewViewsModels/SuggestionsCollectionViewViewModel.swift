//
//  SuggestionsViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.03.2021.
//

import UIKit

class SuggestionsCollectionViewViewModel: SuggestionsCollectionViewViewModelType {

    private var _selectedIndexPath: IndexPath?
    
    func numberOfItems() -> Int {
        return CoreDataManager.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SuggestionsCollectionViewCellViewModelType? {
        let film = CoreDataManager.films[indexPath.row]
        return SuggestionsCollectionViewCellViewModel(film: film)
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: CoreDataManager.films[selectedIndexPath.row], favFilm: nil)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
    func filmToSave(indexPath: IndexPath) -> CurrentFilm {
        guard let indexPath = _selectedIndexPath else { return CurrentFilm() }
        let film = CoreDataManager.films[indexPath.row]
        return film
    }
    
    func filmToDelete(indexPath: IndexPath) -> FavouriteFilm {
        guard let indexPath = _selectedIndexPath else { return FavouriteFilm() }
        let film = CoreDataManager.favouriteFilms[indexPath.row]
        return film
    }
    
}
