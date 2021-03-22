//
//  SuggestionViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.03.2021.
//

import Foundation

protocol SuggestionCollectionViewViewModelType {
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SuggestionCollectionViewCellViewModelType?
}
