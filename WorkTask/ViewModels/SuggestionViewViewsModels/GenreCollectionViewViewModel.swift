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
        return CoreDataManager.genres.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GenreCollectionViewCellViewModelType? {
        let genre = CoreDataManager.genres[indexPath.row]
        return GenreCollectionViewCellViewModel(genre: genre)
    }
}
