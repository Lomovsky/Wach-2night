//
//  SearchVC+SearchBarDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.01.2021.
//

import UIKit

extension SearchViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchURL = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=\(searchLanguage)&query=\(searchText)&page=1&include_adult=false"
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            NetworkManager.fetchCurrentData(withURL: searchURL) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let filmResponse):
                    DispatchQueue.main.async {
                        
                        filmResponse.results.forEach { (film) in
                            SearchViewController.films.append(film)    
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }
}
