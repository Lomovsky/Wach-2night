//
//  SearchViewTableViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class SearchViewTableViewViewModel: SearchViewTableViewViewModelType {

    private var searchTableViewCellViewModel: SearchTableViewCellViewModel?
    
    func numberOfItems() -> Int {
        return SearchViewViewModel.films.count
    }
    

    
    func cellViewModel(forIndexPath indexPath: IndexPath, cell: UITableViewCell) -> SearchViewTableViewCellViewModelType? {
        let film = SearchViewViewModel.films[indexPath.row]
        searchTableViewCellViewModel?.configureTheCell(cell: cell, itemNumber: NSNumber(value: indexPath.item), film: film, indexPath: indexPath)
        return SearchTableViewCellViewModel(title: film.title)
    }
    
}
