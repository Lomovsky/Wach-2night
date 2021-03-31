//
//  GenreCollectionViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

final class GenreCollectionViewViewModel: GenreCollectionViewViewModelType {
    
    private let coreDataManager = CoreDataManager()
    
    func numberOfItems() -> Int {
        return coreDataManager.fetchGenresData().count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GenreCollectionViewCellViewModelType? {
        let genre = coreDataManager.fetchGenresData()[indexPath.row]
        return GenreCollectionViewCellViewModel(genre: genre)
    }
    
    func fetchGenres(indexPath: IndexPath) -> Genre {
        let genre = coreDataManager.fetchGenresData()[indexPath.row]
        return genre
    }
    
}
