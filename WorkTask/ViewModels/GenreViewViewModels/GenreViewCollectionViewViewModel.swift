//
//  GenreViewCollectionViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 29.03.2021.
//

import Foundation

class GenreViewCollectionViewViewModel: GenreViewCollectionViewViewModelType {
    
    private let _coreDataManager = CoreDataManager()
    
    func numberOfItems() -> Int {
        return _coreDataManager.fetchFilmsData().count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GenreViewCollectionViewCellViewModelType? {
        let film = _coreDataManager.fetchFilmsData()[indexPath.row]
        return GenreViewCollectionViewCellViewModel(film: film)
    }
    
    
}
