//
//  SuggestionsViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.03.2021.
//

import UIKit

class SuggestionsCollectionViewViewModel: SuggestionsCollectionViewViewModelType {    
    
    private var _selectedIndexPath: IndexPath?
    private let _coreDataManager = CoreDataManager()

    
    func numberOfItems() -> Int {
        return _coreDataManager.fetchFilmsData().count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SuggestionsCollectionViewCellViewModelType? {
        let film = _coreDataManager.fetchFilmsData()[indexPath.row]
        return SuggestionsCollectionViewCellViewModel(film: film)
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: (_coreDataManager.fetchFilmsData()[selectedIndexPath.row]), searchedFilm: nil)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
    func filmToSave(indexPath: IndexPath) -> CurrentFilm {
        guard let indexPath = _selectedIndexPath else { return CurrentFilm() }
        let film = (_coreDataManager.fetchFilmsData()[indexPath.row]) // TODO
        return film
    }
    
    func filmToDelete(indexPath: IndexPath) -> CurrentFilm {
        guard let indexPath = _selectedIndexPath else { return CurrentFilm() }
        let film = _coreDataManager.fetchFavouriteFilms()[indexPath.row]
        return film
    }
    
}
