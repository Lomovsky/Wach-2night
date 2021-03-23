//
//  PreviewVC+HelperFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.02.2021.
//

import UIKit

extension PreviewViewController {
    
    @objc func addToFavorites() {
        viewModel?.addToFavorites()
        //        self.favoriteButton.setTitle("Удалить из избранного", for: .normal)
        //        self.favoriteButton.removeTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        //        self.favoriteButton.addTarget(self, action: #selector(deleteFromFavorites), for: .touchUpInside)
        //
    }

    @objc func deleteFromFavorites() {

        guard let filmToDelete = PreviewViewController.filmToDelete, let index = PreviewViewController.indexOfFilmToDelete else { return }

        SuggestionsViewController.favouriteFilms.remove(at: index)

        coreDataManager.fetchFavouriteFilms()
        coreDataManager.managedContext.delete(filmToDelete)

        do {
            try coreDataManager.managedContext.save()

        } catch let error as NSError {
            print(error)
        }

        suggestionsDelegate?.updateFavorites()
        dismiss(animated: true)
    }
    
    
}
