//
//  SearchViewTableViewCellViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

final class SearchTableViewCellViewModel: SearchViewTableViewCellViewModelType {
    
    var title: String
    var poster: UIImage?
    
    init(title: String, poster: UIImage) {
        self.title = title
        self.poster = poster
    }
    
}
