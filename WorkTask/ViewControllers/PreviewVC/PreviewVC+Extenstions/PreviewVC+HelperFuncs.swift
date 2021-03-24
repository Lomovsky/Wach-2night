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
        self.favoriteButton.setTitle("Удалить из избранного", for: .normal)
        self.favoriteButton.removeTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        self.favoriteButton.addTarget(self, action: #selector(deleteFromFavorites), for: .touchUpInside)
        viewModel?.suggestionsDelegate?.updateFavorites()
        
    }

    @objc func deleteFromFavorites() {
        
        viewModel?.removeFromFavorites()
        viewModel?.suggestionsDelegate?.updateFavorites()
        dismiss(animated: true)
    }
    
    
}
