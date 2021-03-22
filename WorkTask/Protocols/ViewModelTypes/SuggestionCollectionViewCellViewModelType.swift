//
//  SuggestionCollectionViewCellViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.03.2021.
//

import UIKit

protocol SuggestionCollectionViewCellViewModelType: class {
    
    var poster: UIImage { get }
    var title: String { get }
    var overview: String { get }
    
}
