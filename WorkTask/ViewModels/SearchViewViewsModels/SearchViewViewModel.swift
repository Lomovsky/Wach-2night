//
//  SearchViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

final class SearchViewViewModel: SearchViewViewModelType {
    
    let queue = DispatchQueue(label: "filmsQueue", qos: .utility)
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
                filmResponse.results.forEach { (film) in
                    if let posterPath = film.posterPath {
                        let posterLink = imagePath + posterPath
                        
                        guard let url = URL(string: posterLink) else { return }
                        self.queue.async {
                            do {
                                let posterData = try Data(contentsOf: url)
                                guard let posterImage = UIImage(data: posterData) else { return }
                                let conventedFilm = ConventedFilm(id: film.id, title: film.title, originalTitle: film.originalTitle, poster: posterImage, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating)
                                SearchViewTableViewViewModel.films.append(conventedFilm)
                                DispatchQueue.main.async {
                                    self.searchDelegate?.updateUI()
                                }
                            } catch let error as NSError {
                                assertionFailure("\(error)")
                            }
                        }

                        
                    } else {
                        let poster = #imageLiteral(resourceName: "1024px-No_image_available.svg")
                        let conventedFilm = ConventedFilm(id: film.id, title: film.title, originalTitle: film.originalTitle, poster: poster, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating)
                        SearchViewTableViewViewModel.films.append(conventedFilm)
                        DispatchQueue.main.async {
                            self.searchDelegate?.updateUI()
                        }
                    }
                }
                print("reloaded the data")
            }
        }
    }
    
    
}
