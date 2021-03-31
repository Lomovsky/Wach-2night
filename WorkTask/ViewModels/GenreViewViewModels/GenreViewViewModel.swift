//
//  GenreViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 29.03.2021.
//

import Foundation

final class GenreViewViewModel: GenreViewViewModelType {
    
    private let _dataManager = DataManager()
    
    func downloadFilms(condition: Conditions) {
        _dataManager.downloadFilms(conditions: condition)
    }
    
}
