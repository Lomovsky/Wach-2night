//
//  PreviewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class PreviewViewModel: PreviewViewModelType {
    
    var suggestionsDelegate: SuggestionsDelegate?
    var film: CurrentFilm?
    private var _coreDataManager = CoreDataManager()
    
    
    var poster: UIImage {
        if let defaultPoster = UIImage(named: "1024px-No_image_available.svg") {
            guard let filmPoster = film?.poster else { return defaultPoster }
            guard let poster = UIImage(data: filmPoster) else { return defaultPoster }
            return  poster
        }
        return UIImage()
    }
    
    var title: String {
        return (film?.title) ?? ""
        
    }
    
    var overview: String {
        return (film?.overview) ?? ""
    }
    
    init(currentFilm: CurrentFilm) {
        self.film = currentFilm
    }
    
    
    func addToFavorites(film: CurrentFilm) {
        DispatchQueue.main.async {
            self._coreDataManager.saveFavouriteFilm(film: film)
            self.suggestionsDelegate?.updateFavorites()
        }
    }
    
    func removeFromFavorites() {
        guard let filmToDelete = film else { return }
        _coreDataManager.removeFromFavorites(film: filmToDelete)
        suggestionsDelegate?.updateFavorites()
    }
}

