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
        viewModel?.timer?.invalidate()
        viewModel?.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (_) in
            guard let self = self else { return }
            self.viewModel?.removeAllObjects()
            if let language = NSLinguisticTagger.dominantLanguage(for: searchText) {
                if language == "nb" {
                    searchURL = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(searchText)&page=1&include_adult=false"
                    print("API LINK LOOKS LIKE:\(searchURL)")
                } else {
                    searchURL = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=ru-RU&query=\(searchText)&page=1&include_adult=false".encodeUrl
                    print("API LINK LOOKS LIKE:\(searchURL)")
                }
            }
            self.viewModel?.search(url: searchURL)
        })
    }
}
