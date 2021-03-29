//
//  SearchViewTableViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class SearchViewTableViewViewModel: SearchViewTableViewViewModelType {
    
    let queue = DispatchQueue(label: "images", qos: .utility)
    private var viewModel = SearchViewViewModel()

    func downloadPosters(itemNumber: NSNumber, film: Film, indexPath: IndexPath) {
         
        if let posterPath = film.posterPath {
            let posterUrlString = imagePath + posterPath
            let posterURL = URL(string: posterUrlString)

            if let cashedImage = viewModel.cache.object(forKey: itemNumber) {
              _poster = cashedImage

            } else {
                queue.async {
                    let imageData = try? Data(contentsOf: posterURL!)
                    let poster = UIImage(data: imageData!)
                    let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: 50, height: 50))
                    DispatchQueue.main.async {
                        self.viewModel.cache.setObject(resizedPoster!, forKey: itemNumber)
                        self._poster = resizedPoster ?? #imageLiteral(resourceName: "1024px-No_image_available.svg")
                    }
                }
            }
        } else {
            _poster = #imageLiteral(resourceName: "1024px-No_image_available.svg")
        }
    }

    private var _poster: UIImage = #imageLiteral(resourceName: "1024px-No_image_available.svg") {
        didSet {
            print("did set")
        }
    }
    
    
    func numberOfItems() -> Int {
        return SearchViewViewModel.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath, cell: UITableViewCell) -> SearchViewTableViewCellViewModelType? {
        let film = SearchViewViewModel.films[indexPath.row]
        downloadPosters(itemNumber: NSNumber(value: indexPath.item), film: film, indexPath: indexPath)
        return SearchTableViewCellViewModel(title: film.title, poster: _poster)
    }
    
    
    
}
