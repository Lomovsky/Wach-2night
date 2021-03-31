//
//  SearchViewTableViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

final class SearchViewTableViewViewModel: SearchViewTableViewViewModelType {
    
    let queue = DispatchQueue(label: "images", qos: .utility)
    weak var searchDelegate: SearchDelegate?
    private var _viewModel = SearchViewViewModel()
    private var _selectedIndexPath: IndexPath?
    
    func downloadPosters(itemNumber: NSNumber, film: Film, indexPath: IndexPath) {
        
        if let posterPath = film.posterPath {
            let posterUrlString = imagePath + posterPath
            let posterURL = URL(string: posterUrlString)
            
            if let cashedImage = _viewModel.cache.object(forKey: itemNumber) {
                _poster = cashedImage
//                searchDelegate?.updateUI()
                
            } else {
                queue.async {
                    let imageData = try? Data(contentsOf: posterURL!)
                    let poster = UIImage(data: imageData!)
                    let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: 50, height: 50))
                    DispatchQueue.main.async {
                        self._viewModel.cache.setObject(resizedPoster!, forKey: itemNumber)
                        self._poster = resizedPoster!
                        self.searchDelegate?.updateUI()
                    }
                }
            }
        } else {
            _poster = #imageLiteral(resourceName: "1024px-No_image_available.svg")
//            searchDelegate?.updateUI()
        }
    }
    
    private var _poster: UIImage = #imageLiteral(resourceName: "1024px-No_image_available.svg") {
        didSet {
            print("did set")
        }
    }
    
    
    func numberOfItems() -> Int {
        return _viewModel.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath, cell: UITableViewCell) -> SearchViewTableViewCellViewModelType? {
        let film = _viewModel.films[indexPath.row]
        downloadPosters(itemNumber: NSNumber(value: indexPath.item), film: film, indexPath: indexPath)
//        searchDelegate?.updateUI()
        return SearchTableViewCellViewModel(title: film.title, poster: _poster)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: nil, searchedFilm: _viewModel.films[selectedIndexPath.row])
    }
    
}
