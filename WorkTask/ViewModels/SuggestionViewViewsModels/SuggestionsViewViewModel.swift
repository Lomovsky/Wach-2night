//
//  SuggestionsViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

final class SuggestionsViewViewModel: SuggestionsViewViewModelType {
    
    private let _coreDataManager = CoreDataManager()
    private let _dataManager = DataManager()
    var suggestionsDelegate: SuggestionsDelegate?
    var favoriteFilmsArrayIsEmpty: Bool = true

    
    func downloadFilms(condition: Conditions) {
        switch condition {
        case .download:
            if Reachability.isConnectedToNetwork() {
                _coreDataManager.deleteAllData()
                _dataManager.downloadFilms(conditions: condition)
                _dataManager.downloadGenres()
                _coreDataManager.fetchFavouriteFilms()
                _coreDataManager.deleteAllDataFromFavourites()
                suggestionsDelegate?.stopRefreshing()
                
            } else {
                DispatchQueue.main.async {
                    self.suggestionsDelegate?.updateUIOffline()
                    self.suggestionsDelegate?.stopRefreshing()
                }
            }
            
        default:
            if Reachability.isConnectedToNetwork() {
                _dataManager.downloadFilms(conditions: condition)
                _dataManager.downloadGenres()
                _coreDataManager.fetchFavouriteFilms()
                _coreDataManager.deleteAllDataFromFavourites()
                suggestionsDelegate?.stopRefreshing()
                
            } else {
                DispatchQueue.main.async {
                    self.suggestionsDelegate?.updateUIOffline()
                    self.suggestionsDelegate?.stopRefreshing()
                }
            }
        }

    }
    
}


