//
//  DataManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 15.01.2021.
//

import UIKit

class DataManager {
    let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ru-RU&sort_by=popularity.desc&include_adult=true&include_video=false&page=1"
    var filmResponse: FilmResponse? = nil
    
    @objc func downloadFilms() {
        let coreDataManager = CoreDataManager()
        NetworkManager.fetchCurrentData(withURL: urlString) { [weak self ] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let filmResponse):
                self.filmResponse = filmResponse
                filmResponse.results.forEach { (film) in
                    DispatchQueue.global().async {
                        let secondPath = film.posterPath
                        let imageURLString = imagePath + secondPath
                        guard let imageURL = URL(string: imageURLString) else { return }
                        guard let posterData = try? Data(contentsOf: imageURL) else { return }
                        DispatchQueue.main.async {
                            coreDataManager.save(film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating, originalPoster: posterData)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                NotificationCenter.default.post(name: NSNotification.Name("Ready to reload data"), object: nil)
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
