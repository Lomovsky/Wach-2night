//
//  FavoritesCollectionViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

protocol FavoritesCollectionViewViewModelType {
    
    static var favoriteFilms: [FavouriteFilm] { get set }
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesCollectionViewCellViewModelType?
    func viewModelForSelectedRow() -> PreviewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}
