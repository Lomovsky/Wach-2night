//
//  ViewControllerHelperFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 15.01.2021.
//

import UIKit

extension ViewController {
    // MARK: Helper funcs -
    
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
                        DispatchQueue.main.async { [self] in
                            coreDataManager.save(film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating, originalPoster: posterData)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.collectionView.reloadData()
                                self.activityIndicator.stopAnimating()
                                self.collectionView.isHidden = false
                                self.activityIndicator.isHidden = true
                                self.label.text = "Подборка лучших фильмов по рейтингу"
                                self.refreshControl.endRefreshing()
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        downloadFilms()
    }

    
}


