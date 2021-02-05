//
//  ViewControllerHelperFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 15.01.2021.
//

import UIKit

extension SuggestionsViewController {
    // MARK: Helper funcs -
    
    @objc func downloadFilms() {
        let coreDataManager = CoreDataManager()
        NetworkManager.fetchCurrentData(withURL: urlString) { [ weak self ] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let filmResponse):
                filmResponse.results.forEach { (film) in
                    DispatchQueue.global(qos: .utility).async {
                        let secondPath = film.posterPath
                        let imageURLString = imagePath + secondPath!
                        guard let imageURL = URL(string: imageURLString) else { return }
                        guard let posterData = try? Data(contentsOf: imageURL) else { return }
                        DispatchQueue.main.async {
                            coreDataManager.save(film.title, filmOriginalTitle: film.originalTitle, filmPoster: posterData, releaseDate: film.releaseDate, overview: film.overview, rating: film.rating, originalPoster: posterData)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.recommendationsCollectionView.reloadData()
                                self.activityIndicator.stopAnimating()
                                self.recommendationsCollectionView.isHidden = false
                                self.activityIndicator.isHidden = true
//                                self.label.text = "Рекомендуем к просмотру"
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func updateUI(notification: NSNotification) {
        let coreDataManager = CoreDataManager()
        coreDataManager.fetchData()
        DispatchQueue.main.async {
            self.recommendationsCollectionView.reloadData()
            self.recommendationsCollectionView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    
}


