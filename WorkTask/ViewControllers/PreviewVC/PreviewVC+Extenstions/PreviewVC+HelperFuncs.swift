//
//  PreviewVC+HelperFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.02.2021.
//

import UIKit

extension PreviewViewController {
    
    @objc func addToFavorites() {
//        let coreDataManager = CoreDataManager()
//        self.favoriteButton.setTitle("Удалить из избранного", for: .normal)
//        self.favoriteButton.removeTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
//        self.favoriteButton.addTarget(self, action: #selector(deleteFromFavorites), for: .touchUpInside)
//        coreDataManager.saveFavouriteFilm(film!.title!, filmOriginalTitle: film!.originalTitle!, filmRating: film!.rating, filmOverview: film!.overview!, filmPoster: film!.poster!)
//        suggestionsDelegate?.updateFavorites()
//
//        guard let filmToDelete = SuggestionsViewController.favouriteFilms.last else { return }
//        guard let index = SuggestionsViewController.favouriteFilms.lastIndex(of: filmToDelete) else { return }
//
//        PreviewViewController.filmToDelete = filmToDelete
//        PreviewViewController.indexOfFilmToDelete = index
//        print(SuggestionsViewController.favouriteFilms.count)
//    }
//
//    @objc func deleteFromFavorites() {
//
//        guard let filmToDelete = PreviewViewController.filmToDelete, let index = PreviewViewController.indexOfFilmToDelete else { return }
//
//        SuggestionsViewController.favouriteFilms.remove(at: index)
//
//        coreDataManager.fetchFavouriteFilms()
//        coreDataManager.managedContext.delete(filmToDelete)
//
//        do {
//            try coreDataManager.managedContext.save()
//
//        } catch let error as NSError {
//            print(error)
//        }
//
//        suggestionsDelegate?.updateFavorites()
//        dismiss(animated: true)
    }
    
    
}
