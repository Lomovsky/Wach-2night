//
//  SuggestionsViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.03.2021.
//

import UIKit

class SuggestionsCollectionViewViewModel: SuggestionCollectionViewViewModelType {
    static var films: [CurrentFilm] = []

    func numberOfItems() -> Int {
        return SuggestionsCollectionViewViewModel.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SuggestionCollectionViewCellViewModelType? {
        let film = SuggestionsCollectionViewViewModel.films[indexPath.row]
        return SuggestionCollectionViewCellViewModel(film: film)
    }
    
    
}
