//
//  GenreCollectionViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

class GenreCollectionViewViewModel: GenreCollectionViewViewModelType {
    
    private let coreDataManager = CoreDataManager()
    
    func numberOfItems() -> Int {
        return coreDataManager.fetchGenresData()?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GenreCollectionViewCellViewModelType? {
        guard let genre = coreDataManager.fetchGenresData()?[indexPath.row] else { return nil }
        return GenreCollectionViewCellViewModel(genre: genre)
    }
    
}
