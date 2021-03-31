//
//  SearchViewTableViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

protocol SearchViewTableViewViewModelType {
    
    static var films: [Film] { get set }
    var cache: NSCache<NSNumber, UIImage> { get set }
    var searchDelegate: SearchDelegate? { get set }
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath, cell: UITableViewCell) -> SearchViewTableViewCellViewModelType?
    func viewModelForSelectedRow() -> PreviewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func addAFilm(film: Film)
    func removeAllObjects()

    
}
