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
        coreDataManager.saveFavouriteFilm(film!.title!, filmOriginalTitle: film!.originalTitle!, filmRating: film!.rating, filmOverview: film!.overview!, filmPoster: film!.poster!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update favourite collectionView"), object: nil)
    }
    
    @objc func deleteFromFavorites() {
        guard let film = SuggestionsViewController.favouriteFilms.last as FavouriteFilm? else { return }
        coreDataManager.managedContext.delete(film)
        SuggestionsViewController.favouriteFilms.removeLast()
        
        do {
            try coreDataManager.managedContext.save()
            
        } catch let error as NSError {
            print(error)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update favourite collectionView"), object: nil)
        dismiss(animated: true)
    }
    
    
}
