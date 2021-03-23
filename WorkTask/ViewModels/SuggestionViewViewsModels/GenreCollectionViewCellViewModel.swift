//
//  GenreCollectionViewCellViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

class GenreCollectionViewCellViewModel: GenreCollectionViewCellViewModelType {
    
    private var genre: Genre
    
    var title: String {
        return genre.name ?? ""
    }
    
    init(genre: Genre) {
        self.genre = genre
    }
}
