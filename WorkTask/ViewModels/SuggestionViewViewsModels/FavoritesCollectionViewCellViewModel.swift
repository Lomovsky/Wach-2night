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
        guard let data = _film.poster else { return #imageLiteral(resourceName: "1024px-No_image_available.svg") }
        guard let poster = UIImage(data: data) else { return #imageLiteral(resourceName: "1024px-No_image_available.svg")}
        return poster
    }
    
    init(film: FavouriteFilm) {
        self._film = film
    }
}
