//
//  SearchViewTableViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

protocol SearchViewTableViewViewModelType {
    
    var searchDelegate: SearchDelegate? { get set }
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath, cell: UITableViewCell) -> SearchViewTableViewCellViewModelType?
    func viewModelForSelectedRow() -> PreviewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    
}
