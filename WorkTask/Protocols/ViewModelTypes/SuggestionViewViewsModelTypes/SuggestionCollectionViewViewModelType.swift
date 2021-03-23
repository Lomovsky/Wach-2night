//
//  SuggestionsCollectionViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

protocol SuggestionsCollectionViewViewModelType {
    
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SuggestionsCollectionViewCellViewModelType?
    
}
