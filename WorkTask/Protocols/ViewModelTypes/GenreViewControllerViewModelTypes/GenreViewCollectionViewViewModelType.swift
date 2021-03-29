//
//  GenreViewCollectionViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 29.03.2021.
//

import Foundation

protocol GenreViewCollectionViewViewModelType {
    
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GenreViewCollectionViewViewModelType?
//    func fetchGenres(indexPath: IndexPath) -> Genre
    
}
