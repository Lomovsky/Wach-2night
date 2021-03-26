//
//  DataDownloadingManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 21.03.2021.
//

import UIKit

final class DataManager {
    
    static var suggestionsDelegate: SuggestionsDelegate?
    
    let downloadQueue = DispatchQueue(label: "networkQueue", qos: .utility)
    let savingQueue = DispatchQueue(label: "savingQueue", qos: .userInitiated)
    
    func downloadGenres() {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=ru-RU"
        let coreDataManager = CoreDataManager()
        NetworkManager.fetchCurrentData(withURL: urlString, dataModel: Genres.self) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let genreResponse):
                genreResponse.genres.forEach { [unowned self] (genre) in
                    self.savingQueue.async {
                        coreDataManager.saveGenres(genre.id, genreName: genre.name)
                        DispatchQueue.main.async {
                            DataManager.suggestionsDelegate?.updateGenresUI()
                        }
                    }
                }
            }
        }
    }
    
    
    
    func downloadFilms(conditions: Conditions) {
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ru-RU&sort_by=popularity.desc&include_adult=true&include_video=false&page=1"
        let coreDataManager = CoreDataManager()
        NetworkManager.fetchCurrentData(withURL: urlString, dataModel: FilmResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let filmResponse):
                filmResponse.results.forEach { (film) in
                    if let secondPath = film.posterPath {
                        self.downloadQueue.async { [unowned self] in
                            let imageURLString = imagePath + secondPath
                            guard let imageURL = URL(string: imageURLString) else { return }
                            guard let posterData = try? Data(contentsOf: imageURL) else { return }
                            self.savingQueue.async {
                                switch conditions {
                                case .download:
                                    coreDataManager.saveFilms(film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating, id: film.id)
                                    
                                default:
                                    coreDataManager.checkForExistance(filmTitle: film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating, id: film.id)
                                }
                                if coreDataManager.fetchFilmsData()!.count >= 20 {
                                    DispatchQueue.main.async {
                                        DataManager.suggestionsDelegate?.uppateUIAfterDownloadingData()
                                    }
                                }
                            }
                        }
                    } else {
                        let posterPlaceholder: UIImage = #imageLiteral(resourceName: "1024px-No_image_available.svg")
                        guard let posterPlaceholderData = posterPlaceholder.pngData() else { return }
                        self.savingQueue.async {
                            switch conditions {
                            case .download:
                                coreDataManager.saveFilms(film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterPlaceholderData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating, id: film.id)
                                
                            default:
                                coreDataManager.checkForExistance(filmTitle: film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterPlaceholderData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating, id: film.id)
                                
                            }
                            if coreDataManager.fetchFilmsData()!.count >= 20 {
                                DispatchQueue.main.async {
                                    DataManager.suggestionsDelegate?.uppateUIAfterDownloadingData()
                                }
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
