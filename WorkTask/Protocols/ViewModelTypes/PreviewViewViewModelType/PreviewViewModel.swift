//
//  PreviewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class PreviewViewModel: PreviewViewModelType {
    
    var film: CurrentFilm?
    var favFilm: FavouriteFilm?
    
    var poster: UIImage {
        if film != nil {
            let posterImage = UIImage(data: (film?.poster)!)
            return posterImage!
        } else {
            
            let posterImage = UIImage(data: (favFilm?.poster)!)
            return posterImage!
        }
    }
    
    var title: String {
        if film != nil {
            return (film?.title)!
        } else {
            return (favFilm?.title)!
        }
    }
    
    var overview: String {
        if film != nil {
            return (film?.overview)!
        } else {
            return (favFilm?.overview)!
        }
    }
    
    init(currentFilm: CurrentFilm?, favFilm: FavouriteFilm?) {
        self.film = currentFilm
        self.favFilm = favFilm
    }
    
}

