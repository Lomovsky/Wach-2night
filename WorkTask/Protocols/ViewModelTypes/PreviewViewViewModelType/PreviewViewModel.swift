//
//  PreviewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class PreviewViewModel: PreviewViewModelType {
    
    private var coreDataManager = CoreDataManager()
    var suggestionsDelegate: SuggestionsDelegate?
    var film: CurrentFilm?
    var favFilm: FavouriteFilm?
    var filmToDelete: FavouriteFilm?
    var indexToRemove: Int?
    var filmToAdd: CurrentFilm?
    
    
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
    
  
    func addToFavorites() {
        guard let filmToAdd = filmToAdd else { return }
        coreDataManager.saveFavouriteFilm(filmToAdd.title ?? "", filmOriginalTitle: filmToAdd.originalTitle ?? "", filmRating: filmToAdd.rating, filmOverview: filmToAdd.overview ?? "", filmPoster: filmToAdd.poster!)
        suggestionsDelegate?.updateFavorites()
    }
    
    func removeFromFavorites() {
        guard let filmToDelete = filmToDelete else { return }
        coreDataManager.removeFromFavorites(film: filmToDelete)
        suggestionsDelegate?.updateFavorites()
    }
    
}

