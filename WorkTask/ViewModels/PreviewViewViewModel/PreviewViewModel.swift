//
//  PreviewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit



final class PreviewViewModel: PreviewViewModelType {
    
    var suggestionsDelegate: SuggestionsDelegate?
    var film: CurrentFilm?
    var searchedFilm: Film?
    private var _coreDataManager = CoreDataManager()
    let queue = DispatchQueue(label: "imageQueue", qos: .utility)
    
    
    
    var poster: UIImage {
        if film != nil {
            if let defaultPoster = UIImage(named: "1024px-No_image_available.svg") {
                guard let filmPoster = film?.poster else { return defaultPoster }
                guard let poster = UIImage(data: filmPoster) else { return defaultPoster }
                return  poster
            }
        } else {
            return UIImage(named: "1024px-No_image_available.svg")!
        }
        
        return UIImage()
    }
    
    var title: String {
        if film != nil {
            return (film?.title) ?? "Нет данных"
        } else {
            return searchedFilm?.title ?? "Нет данных"
        }
        
    }
    
    var overview: String {
        if film != nil {
            return (film?.overview) ?? "Нет данных"
            
        } else {
            return searchedFilm?.overview ?? "Нет данных"
        }
    }
    
    init(currentFilm: CurrentFilm?, searchedFilm: Film?) {
        self.film = currentFilm
        self.searchedFilm = searchedFilm
        
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
    
//    func downloadImage(film: Film) -> UIImage {
//        var poster = UIImage()
//
//        if let posterPath = film.posterPath {
//            let posterURL = imagePath + posterPath
//            DispatchQueue.main.async {
//                guard let url = URL(string: posterURL) else { return }
//                do {
//                    let posterData = try Data(contentsOf: url)
//                    let image = UIImage(data: posterData)
//                    poster = image!
//                } catch let error as NSError {
//                    assertionFailure("\(error)")
//                }
//            }
//        }
//        return poster
//    }
//
}

