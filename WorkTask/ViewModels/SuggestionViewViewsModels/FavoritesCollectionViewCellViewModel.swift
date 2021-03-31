//
//  FavoritesCollectionViewCellViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

final class FavoritesCollectionViewCellViewModel: FavoritesCollectionViewCellViewModelType {
    
    private var _film: CurrentFilm
    
    
    var poster: UIImage {
        if let defaultPoster = UIImage(named: "1024px-No_image_available.svg") {
            guard let data = _film.poster else { return defaultPoster }
            guard let poster = UIImage(data: data) else { return defaultPoster }
            return poster
        }
        return UIImage()
    }
    
    init(film: CurrentFilm) {
        self._film = film
    }

}
