//
//  SuggestionsViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

final class SuggestionsViewViewModel: SuggestionsViewViewModelType {
    
    private let coreDataManager = CoreDataManager()
    private let dataManager = DataManager()
    var suggestionsDelegate: SuggestionsDelegate?
    var favoriteFilmsArrayIsEmpty: Bool = true

    
    func downloadFilms() {
        if Reachability.isConnectedToNetwork() {
            coreDataManager.deleteAllData()
            dataManager.downloadFilms()
            dataManager.downloadGenres()
            coreDataManager.deleteAllDataFromFavourites()
            
        } else {
            DispatchQueue.main.async {
                self.suggestionsDelegate?.updateUIOffline()
            }
        }
    }
    
}


