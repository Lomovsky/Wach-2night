//
//  SuggestionCollectionViewCelllViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.03.2021.
//

import UIKit

final class SuggestionsCollectionViewCellViewModel: SuggestionsCollectionViewCellViewModelType {
    
    private var _film: CurrentFilm
    
    var poster: UIImage {
        if let defaultPoster = UIImage(named: "1024px-No_image_available.svg") {
            guard let filmPoster = _film.poster else { return defaultPoster }
            guard let poster = UIImage(data: filmPoster) else { return defaultPoster }
            return  poster
        }
        return UIImage()
    }
    
    var title: String {
        return _film.title ?? "Нет данных"
    }
    
    var overview: String {
        return _film.overview ?? "Нет данных"
    }
    
    init(film: CurrentFilm) {
        self._film = film
    }
}
