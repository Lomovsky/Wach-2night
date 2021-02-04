//
//  SearchVC+SearchBarDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.01.2021.
//

import UIKit
import NaturalLanguage

extension SearchViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchURL = ""
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            if let language = NSLinguisticTagger.dominantLanguage(for: searchText) {
                if language == "nb" {
                    searchURL = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(searchText)&page=1&include_adult=false"
                    print("API LINK LOOKS LIKE:\(searchURL)")
                } else {
                    searchURL = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=ru-RU&query=\(searchText)&page=1&include_adult=false".encodeUrl
                    print("API LINK LOOKS LIKE:\(searchURL)")
                }
            }
            NetworkManager.fetchCurrentData(withURL: searchURL) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let filmResponse):
                    DispatchQueue.main.async {
                        self.filmResponse = filmResponse
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }
}
