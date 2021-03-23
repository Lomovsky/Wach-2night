//
//  FavoritesCollectionViewCellViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class FavoritesCollectionViewCellViewModel: FavoritesCollectionViewCellViewModelType {
    
    private var _film: FavouriteFilm
    
    var poster: UIImage {
        let poster = UIImage(data: _film.poster!)
        return poster!
    }
    
    init(film: FavouriteFilm) {
        self._film = film
    }
}
