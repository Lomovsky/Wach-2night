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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update favourite collectionView"), object: nil)
        print(SuggestionsViewController.favouriteFilms.count)
    }
    
    @objc func deleteFromFavorites() {
        guard let film = SuggestionsViewController.favouriteFilms.last as FavouriteFilm? else { return }
        SuggestionsViewController.favouriteFilms.removeLast()
     
        coreDataManager.fetchFavouriteFilms()
        coreDataManager.managedContext.delete(film)
        
        do {
            try coreDataManager.managedContext.save()
            
        } catch let error as NSError {
            print(error)
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update favourite collectionView"), object: nil)
        dismiss(animated: true)
    }
    
    
}
