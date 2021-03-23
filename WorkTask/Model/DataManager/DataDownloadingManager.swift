//
//  DataDownloadingManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 21.03.2021.
//

import UIKit

 final class DataManager {
    
     static var suggestionsDelegate: SuggestionsDelegate?
    
     func downloadGenres() {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=ru-RU"
        let coreDataManager = CoreDataManager()
        NetworkManager.fetchCurrentData(withURL: urlString, dataModel: Genres.self) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let genreResponse):
                genreResponse.genres.forEach { (genre) in
                    coreDataManager.saveGenres(genre.id, genreName: genre.name)
                    DataManager.suggestionsDelegate?.uppateUIAfterDownloadingData()
                    
                }
            }
        }
    }
    
    func downloadFilms() {
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ru-RU&sort_by=popularity.desc&include_adult=true&include_video=false&page=1"
        let coreDataManager = CoreDataManager()
        NetworkManager.fetchCurrentData(withURL: urlString, dataModel: FilmResponse.self) { (result) in
            switch result {
            case .success(let filmResponse):
                filmResponse.results.forEach { (film) in
                    if let secondPath = film.posterPath {
                        DispatchQueue.global(qos: .utility).async {
                            let imageURLString = imagePath + secondPath
                            guard let imageURL = URL(string: imageURLString) else { return }
                            guard let posterData = try? Data(contentsOf: imageURL) else { return }
                            DispatchQueue.main.async {
                                coreDataManager.saveFilms(film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating)
                                DispatchQueue.main.async {
                                    DataManager.suggestionsDelegate?.uppateUIAfterDownloadingData()
                                    print("FINISHED DOWNLOADING FILMS")  //PRINTING
                                }
                            }
                        }
                    } else {
                        let posterPlaceholder: UIImage = #imageLiteral(resourceName: "1024px-No_image_available.svg")
                        guard let posterPlaceholderData = posterPlaceholder.pngData() else { return }
                        DispatchQueue.main.async {
                            coreDataManager.saveFilms(film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterPlaceholderData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                DataManager.suggestionsDelegate?.uppateUIAfterDownloadingData()
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
