//
//  SearchViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class SearchViewViewModel: SearchViewViewModelType {
    
    static var films: [Film] = []
    var searchDelegate: SearchDelegate?
    var cache = NSCache<NSNumber, UIImage>()
    let searchController = UISearchController(searchResultsController: nil)
    let cellID = "Cell"
    var timer: Timer?
    
    
    func search(url: String) {
        NetworkManager.fetchCurrentData(withURL: url, dataModel: FilmResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let filmResponse):
                filmResponse.results.enumerated().forEach { [weak self] (film) in
                        guard let self = self else { return }
                    SearchViewViewModel.films.insert(film.element, at: film.offset)
                        print(SearchViewViewModel.films.count)
                    }
                self.searchDelegate?.updateUI()
                        print("reloaded the data")
            }
        }
    }
    
}
