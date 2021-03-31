//
//  SearchViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

final class SearchViewViewModel: SearchViewViewModelType {
    
    let searchController = UISearchController(searchResultsController: nil)
    private let _tableViewModel = SearchViewTableViewViewModel()
    weak var searchDelegate: SearchDelegate?
    var timer: Timer?
    
    func search(url: String) {
        let networkManager = NetworkManager()
        _tableViewModel.removeAllObjects()
        searchDelegate?.updateUI()
        networkManager.fetchCurrentData(withURL: url, dataModel: FilmResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let filmResponse):
                filmResponse.results.forEach { [unowned self] (film) in
                    self._tableViewModel.addAFilm(film: film)
                    print(SearchViewTableViewViewModel.films.count)
                    self.searchDelegate?.updateUI()

                }
                print("reloaded the data")
            }
        }
    }
    
    
}
