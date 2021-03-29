//
//  SearchViewTableViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

protocol SearchViewTableViewViewModelType {
    
    
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath, cell: UITableViewCell) -> SearchViewTableViewCellViewModelType?

}
