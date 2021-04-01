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
    static var films: [ConventedFilm] = []
    var cache = NSCache<NSNumber, UIImage>()
    private var _selectedIndexPath: IndexPath?
    
    
    func numberOfItems() -> Int {
        return SearchViewTableViewViewModel.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath, cell: UITableViewCell) -> SearchViewTableViewCellViewModelType? {
        let film = SearchViewTableViewViewModel.films[indexPath.row]
        downloadPosters(film: film, indexPath: indexPath, cell: cell)
        return SearchTableViewCellViewModel(title: film.title)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        _selectedIndexPath = indexPath
    }
    
    func viewModelForSelectedRow() -> PreviewViewModelType? {
        guard let selectedIndexPath = _selectedIndexPath else { return nil }
        return PreviewViewModel(currentFilm: nil, searchedFilm: SearchViewTableViewViewModel.films[selectedIndexPath.row])
    }
    
    func addAFilm(film: ConventedFilm) {
        SearchViewTableViewViewModel.films.append(film)
    }
    
    func removeAllObjects() {
        cache.removeAllObjects()
        SearchViewTableViewViewModel.films.removeAll()
    }
    
    func downloadPosters(film: ConventedFilm, indexPath: IndexPath, cell: UITableViewCell) {
        cell.imageView?.image = #imageLiteral(resourceName: "1024px-No_image_available.svg")
        
        let resizedPoster = film.poster?.resizeImageUsingVImage(size: .init(width: 60, height: 60))
        cell.imageView?.image = resizedPoster
    }
    
}
