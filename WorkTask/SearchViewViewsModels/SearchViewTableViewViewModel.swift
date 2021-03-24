//
//  SearchViewTableViewViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

class SearchViewTableViewViewModel: SearchViewTableViewViewModelType {
    
    private var viewModel = SearchViewViewModel()
    
    func numberOfItems() -> Int {
        return viewModel.films.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SearchViewTableViewCellViewModelType? {
        let film = viewModel.films[indexPath.row]
        return SearchTableViewCellViewModel(film: film)
    }
    
    
    
}
