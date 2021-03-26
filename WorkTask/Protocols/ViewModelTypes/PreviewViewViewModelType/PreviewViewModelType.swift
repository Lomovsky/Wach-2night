//
//  PreviewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

protocol PreviewViewModelType {
    
    var film: CurrentFilm? { get set }
    var favFilm: FavouriteFilm? { get set }
    var poster: UIImage { get }
    var title: String { get }
    var overview: String { get }
    var suggestionsDelegate: SuggestionsDelegate? { get set }
    var filmToDelete: FavouriteFilm? { get set }
    var indexToRemove: Int? { get set }
    func addToFavorites()
    func removeFromFavorites()
    func filmToSave(film: CurrentFilm)
    func filmToDelete(film: FavouriteFilm)
}
