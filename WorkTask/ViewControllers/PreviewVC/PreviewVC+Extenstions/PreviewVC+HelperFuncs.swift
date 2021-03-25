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
//        viewModel?.suggestionsDelegate?.updateFavorites()
        favoriteButton.setTitle("Удалить из избранного", for: .normal)
        favoriteButton.removeTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(deleteFromFavorites), for: .touchUpInside)
        
    }

    @objc func deleteFromFavorites() {
        
        viewModel?.removeFromFavorites()
        viewModel?.suggestionsDelegate?.updateFavorites()
        dismiss(animated: true)
    }
    
    
}
