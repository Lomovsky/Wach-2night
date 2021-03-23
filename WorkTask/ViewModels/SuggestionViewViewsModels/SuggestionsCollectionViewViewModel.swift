//
//  SuggestionsViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.03.2021.
//

import UIKit

class SuggestionsCollectionViewViewModel: SuggestionsCollectionViewViewModelType {
    
    private let coreDataManager = CoreDataManager()
    
    func numberOfItems() -> Int {
        return CoreDataManager.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SuggestionsCollectionViewCellViewModelType? {
        let film = CoreDataManager.films[indexPath.row]
        return SuggestionsCollectionViewCellViewModel(film: film)
    }
    
    
}
