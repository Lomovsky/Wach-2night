//
//  GenreViewCollectionViewCellViewModel .swift
//  WorkTask
//
//  Created by Алекс Ломовской on 29.03.2021.
//

import UIKit

final class GenreViewCollectionViewCellViewModel: GenreViewCollectionViewCellViewModelType {
    
    private var _film: CurrentFilm
    
    var poster: UIImage {
        let posterImage = UIImage(data: _film.poster!)
        return posterImage!
    }
    
    init(film: CurrentFilm) {
        self._film = film
    }
}
