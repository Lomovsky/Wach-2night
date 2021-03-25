//
//  SuggestionsViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.03.2021.
//

import UIKit

class SuggestionsCollectionViewViewModel: SuggestionsCollectionViewViewModelType {
    
    private var _selectedIndexPath: IndexPath?
    private let coreDataManager = CoreDataManager()
    
    func numberOfItems() -> Int {
        return coreDataManager.fetchFilmsData()?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SuggestionsCollectionViewCellViewModelType? {
        guard let film = coreDataManager.fetchFilmsData()?[indexPath.row] else { return nil }
        return SuggestionsCollectionViewCellViewModel(film: film)
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: coreDataManager.fetchFilmsData()?[selectedIndexPath.row], favFilm: nil)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
    func filmToSave(indexPath: IndexPath) -> CurrentFilm {
        guard let indexPath = _selectedIndexPath else { return CurrentFilm() }
        let film = (coreDataManager.fetchFilmsData()?[indexPath.row])! // TODO
        return film
    }
    
    func filmToDelete(indexPath: IndexPath) -> FavouriteFilm {
        guard let indexPath = _selectedIndexPath else { return FavouriteFilm() }
        let film = coreDataManager.fetchFavouriteFilms()?[indexPath.row]
        return film! //TODO
    }
    
}
