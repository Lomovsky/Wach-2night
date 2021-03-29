//
//  SearchViewTableViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class SearchViewTableViewViewModel: SearchViewTableViewViewModelType {
    let queue = DispatchQueue(label: "images", qos: .utility)
    
    func configureTheCell(cell: UITableViewCell ,itemNumber: NSNumber, film: Film, indexPath: IndexPath) -> UIImage {
         
        if let posterPath = film.posterPath {
            let posterUrlString = imagePath + posterPath
            let posterURL = URL(string: posterUrlString)

            if let cashedImage = viewModel.cache.object(forKey: itemNumber) {
                return cashedImage
//                cell.imageView?.image = cashedImage
//                cell.imageView?.clipsToBounds =  true
//                cell.imageView?.layer.cornerRadius = 20
            } else {
                queue.async {
                    let imageData = try? Data(contentsOf: posterURL!)
                    let poster = UIImage(data: imageData!)
                    let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: 50, height: 50))
                    DispatchQueue.main.async {
                        self.viewModel.cache.setObject(resizedPoster!, forKey: itemNumber)
//                        return resizedPoster
                    }
                }
            }
        } else {
            return UIImage(named: "1024px-No_image_available.svg")!
        }
    }

    
    func casheImages() {
        
    }
    
    private var viewModel = SearchViewViewModel()
    
    func numberOfItems() -> Int {
        return SearchViewViewModel.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath, cell: UITableViewCell) -> SearchViewTableViewCellViewModelType? {
        let film = SearchViewViewModel.films[indexPath.row]
        return SearchTableViewCellViewModel(title: film.title, poster: <#T##UIImage#>)
    }
    
    
    
}
