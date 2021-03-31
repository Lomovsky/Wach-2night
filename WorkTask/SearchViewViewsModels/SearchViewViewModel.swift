//
//  SearchViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

final class SearchViewViewModel: SearchViewViewModelType {
    
    var films: [Film] = []
    let searchController = UISearchController(searchResultsController: nil)
    weak var searchDelegate: SearchDelegate?
    var cache = NSCache<NSNumber, UIImage>()
    var timer: Timer?
    
    
    func search(url: String) {
        let networkManager = NetworkManager()
        networkManager.fetchCurrentData(withURL: url, dataModel: FilmResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let filmResponse):
                filmResponse.results.forEach { [unowned self] (film) in
                    self.films.append(film)
                    print(self.films.count)
                    }
                self.searchDelegate?.updateUI()
                        print("reloaded the data")
            }
        }
    }
    
    func removeAllObjects() {
        cache.removeAllObjects()
        films.removeAll()
    }
}
