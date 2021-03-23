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
    
    
    func downloadFilms() {
        if Reachability.isConnectedToNetwork() {
            coreDataManager.deleteAllData()
            coreDataManager.fetchFavouriteFilms()
            dataManager.downloadFilms()
            dataManager.downloadGenres()
            
        } else {
            coreDataManager.fetchFilmsData()
            coreDataManager.fetchGenresData()
            coreDataManager.fetchFavouriteFilms()
            DispatchQueue.main.async {
                self.suggestionsDelegate?.updateUIOffline()
            }
        }
    }
    
}


