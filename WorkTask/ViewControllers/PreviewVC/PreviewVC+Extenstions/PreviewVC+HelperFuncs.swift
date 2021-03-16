//
//  PreviewVC+HelperFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.02.2021.
//

import UIKit

extension PreviewViewController {
    
    @objc func addToFavorites() {
        let coreDataManager = CoreDataManager()
        self.favoriteButton.setTitle("Удалить из избранного", for: .normal)
        self.favoriteButton.removeTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        self.favoriteButton.addTarget(self, action: #selector(deleteFromFavorites), for: .touchUpInside)
        coreDataManager.saveFavouriteFilm(film!.title!, filmOriginalTitle: film!.originalTitle!, filmRating: film!.rating, filmOverview: film!.overview!, filmPoster: film!.poster!)
        suggestionsDelegate?.updateFavorites()
        guard let film1 = SuggestionsViewController.favouriteFilms.last else { return }
        let index = SuggestionsViewController.favouriteFilms.endIndex
        let filmToRemove = FilmToDelete(film: film1, index: index)
        
        filmToDelete = filmToRemove
        print(SuggestionsViewController.favouriteFilms.count)
    }
    
    @objc func deleteFromFavorites() {
        


        
        guard let filmToDelete = filmToDelete else { return }
        SuggestionsViewController.favouriteFilms.remove(at: filmToDelete.index)
        
        coreDataManager.fetchFavouriteFilms()
        coreDataManager.managedContext.delete(filmToDelete.film)
        
        do {
            try coreDataManager.managedContext.save()
            
        } catch let error as NSError {
            print(error)
        }

        suggestionsDelegate?.updateFavorites()
        dismiss(animated: true)
    }
    
    
}
