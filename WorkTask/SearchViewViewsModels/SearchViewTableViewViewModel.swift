//
//  SearchViewTableViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class SearchViewTableViewViewModel: SearchViewTableViewViewModelType {
    
//    func configureTheCell(cell: UITableViewCell ,itemNumber: NSNumber, film: Film, indexPath: IndexPath) {
         
//        if let posterPath = film.posterPath {
//            let posterUrlString = imagePath + posterPath
//            let posterURL = URL(string: posterUrlString)
//
//            if let cashedImage = viewModel.cache.object(forKey: itemNumber) {
//                cell.imageView?.image = cashedImage
//                cell.imageView?.clipsToBounds =  true
//                cell.imageView?.layer.cornerRadius = 20
//            } else {
//                DispatchQueue.global(qos: .utility).async {
//                    let imageData = try? Data(contentsOf: posterURL!)
//                    let poster = UIImage(data: imageData!)
//                    let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: 50, height: 50))
//                    DispatchQueue.main.async {
//                        cell.imageView?.image = resizedPoster
//                        cell.imageView?.clipsToBounds =  true
//                        cell.imageView?.layer.cornerRadius = 20
//                        self.viewModel.cache.setObject(resizedPoster!, forKey: itemNumber)
//                    }
//                }
//            }
//        } else {
//            cellViewModel(forIndexPath: indexPath)
//        }
//    }
//
    
    func casheImages() {
        
    }
    
    private var viewModel = SearchViewViewModel()
    
    func numberOfItems() -> Int {
        return SearchViewViewModel.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SearchViewTableViewCellViewModelType? {
        let film = SearchViewViewModel.films[indexPath.row]
        return SearchTableViewCellViewModel(film: film)
    }
    
    
    
}
