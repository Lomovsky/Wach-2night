//
//  FavoritesCollectionViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

protocol FavoritesCollectionViewViewModelType {
    
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesCollectionViewCellViewModelType?
    
}
