//
//  ViewControllerHelperFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 15.01.2021.
//

import UIKit

extension SuggestionsViewController {
    
    func checkConnection() {
        let coreDataManager = CoreDataManager()
        if Reachability.isConnectedToNetwork() {
            coreDataManager.deleteAllData()
            coreDataManager.fetchFavouriteFilms()
            downloadFilms()
            downloadGenres()
            
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
            
        }
    }
    
    func downloadGenres() {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=ru-RU"
        let coreDataManager = CoreDataManager()
        
        NetworkManager.fetchCurrentData(withURL: urlString, dataModel: Genres.self) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let genreResponse):
                genreResponse.genres.forEach { (genre) in
                    coreDataManager.saveGenres(genre.id, genreName: genre.name)
                    self.genreCollectionView.reloadData()
                }
            }
        }
    }
    
    func downloadFilms() {
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ru-RU&sort_by=popularity.desc&include_adult=true&include_video=false&page=1"
        let coreDataManager = CoreDataManager()
        NetworkManager.fetchCurrentData(withURL: urlString, dataModel: FilmResponse.self) { [weak self] (result) in
            guard let self = self else { return }
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.recommendationsCollectionView.reloadData()
                                    self.recommendationsCollectionView.isHidden = false
                                    self.activityIndicator.stopAnimating()
                                    self.activityIndicator.isHidden = true
                                }
                            }
                        }
                    } else {
                        let posterPlaceholder: UIImage = #imageLiteral(resourceName: "1024px-No_image_available.svg")
                        guard let posterPlaceholderData = posterPlaceholder.pngData() else { return }
                        DispatchQueue.main.async {
                            coreDataManager.saveFilms(film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterPlaceholderData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.recommendationsCollectionView.reloadData()
                                self.recommendationsCollectionView.isHidden = false
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.isHidden = true
                            }
                        }
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @objc func showSearch() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func showSettingsVC() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc func updateUI(notification: NSNotification) {
        let coreDataManager = CoreDataManager()
        coreDataManager.fetchFilmsData()
        coreDataManager.fetchGenresData()
        coreDataManager.fetchFavouriteFilms()
        DispatchQueue.main.async {
            self.recommendationsCollectionView.reloadData()
            self.recommendationsCollectionView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.genreCollectionView.reloadData()
            self.favouriteFilmsCollectionView.reloadData()
            self.recommendationsCollectionView.reloadData()
        }
    }
    
    @objc func updateFavouriteCollectionView(notification: NSNotification) {
        let coreDataManager = CoreDataManager()
        coreDataManager.fetchFavouriteFilms()
        DispatchQueue.main.async {
            self.favouriteFilmsCollectionView.reloadData()
        }
    }
    
    @objc func refreshRecommendations(notification: NSNotification) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        downloadFilms()
    }
    
    
    func animateCell(cell: UICollectionViewCell) {
        
        UIView.animate(withDuration: 0.2,
                       animations: {
                        //Fade-out
                        cell.alpha = 0.5
                       }) { (completed) in
            UIView.animate(withDuration: 0.2,
                           animations: {
                            //Fade-out
                            cell.alpha = 1
                           })
        }
    }
    
    
}


