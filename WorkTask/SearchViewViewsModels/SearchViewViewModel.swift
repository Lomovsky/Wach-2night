//
//  SearchViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

class SearchViewViewModel: SearchViewViewModelType {
    
    var films: [Film] = []
    var searchDelegate: SearchDelegate?
    
    func search(url: String) {
        NetworkManager.fetchCurrentData(withURL: url, dataModel: FilmResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let filmResponse):
                filmResponse.results.enumerated().forEach { [weak self] (film) in
                        guard let self = self else { return }
                        self.films.insert(film.element, at: film.offset)
                        print(self.films.count)
                    }
                self.searchDelegate?.updateUI()
                        print("reloaded the data")

            }
        }
    }
    
}
