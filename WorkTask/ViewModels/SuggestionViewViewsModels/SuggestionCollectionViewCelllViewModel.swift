//
//  SuggestionCollectionViewCelllViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.03.2021.
//

import UIKit

class SuggestionsCollectionViewCellViewModel: SuggestionsCollectionViewCellViewModelType {
    
    private var _film: CurrentFilm
    
    var poster: UIImage {
        let filmPoster = UIImage(data: _film.poster!)
//        let resizedPoster = filmPoster?.resizeImageUsingVImage(size: .init(width: <#T##CGFloat#>, height: <#T##CGFloat#>))
        
        return  filmPoster!
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
