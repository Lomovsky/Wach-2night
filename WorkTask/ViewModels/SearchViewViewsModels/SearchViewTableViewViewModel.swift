//
//  SearchViewTableViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class SearchViewTableViewViewModel: SearchViewTableViewViewModelType {
    
    let queue = DispatchQueue(label: "images", qos: .utility)
    weak var searchDelegate: SearchDelegate?
    static var films: [Film] = []
    var cache = NSCache<NSNumber, UIImage>()
    private var _selectedIndexPath: IndexPath?
    
//    private var _poster: UIImage = #imageLiteral(resourceName: "1024px-No_image_available.svg") {
//        didSet {
//            print("did set")
//        }
//    }
    
    func numberOfItems() -> Int {
        return SearchViewTableViewViewModel.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath, cell: UITableViewCell) -> SearchViewTableViewCellViewModelType? {
        let film = SearchViewTableViewViewModel.films[indexPath.row]
        downloadPosters(itemNumber: NSNumber(value: indexPath.item), film: film, indexPath: indexPath, cell: cell)
        //        searchDelegate?.updateUI()
        return SearchTableViewCellViewModel(title: film.title)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: nil, searchedFilm: SearchViewTableViewViewModel.films[selectedIndexPath.row])
    }
    
    func addAFilm(film: Film) {
        SearchViewTableViewViewModel.films.append(film)
    }
    
    func removeAllObjects() {
        cache.removeAllObjects()
        SearchViewTableViewViewModel.films.removeAll()
    }
    
    func downloadPosters(itemNumber: NSNumber, film: Film, indexPath: IndexPath, cell: UITableViewCell) {
        
        if let posterPath = film.posterPath {
            let posterUrlString = imagePath + posterPath
            let posterURL = URL(string: posterUrlString)
            
            if let cashedImage = cache.object(forKey: itemNumber) {
//                _poster = cashedImage
                cell.imageView?.image = cashedImage
                
            } else {
                queue.async {
                    let imageData = try? Data(contentsOf: posterURL!)
                    let poster = UIImage(data: imageData!)
                    let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: 50, height: 50))
                    DispatchQueue.main.async {
                        self.cache.setObject(resizedPoster!, forKey: itemNumber)
                        cell.imageView?.image = resizedPoster
                        //                        self.searchDelegate?.updateUI()
                    }
                }
            }
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "1024px-No_image_available.svg")
            //            searchDelegate?.updateUI()
        }
    }
    
}
