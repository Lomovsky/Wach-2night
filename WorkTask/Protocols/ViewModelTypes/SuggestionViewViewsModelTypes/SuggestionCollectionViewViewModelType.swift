//
//  SuggestionsCollectionViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

protocol SuggestionsCollectionViewViewModelType {
    
    func filmToSave(indexPath: IndexPath) -> CurrentFilm
    func filmToDelete(indexPath: IndexPath) -> CurrentFilm
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SuggestionsCollectionViewCellViewModelType?
    func viewModelForSelectedRow() -> PreviewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)

}




