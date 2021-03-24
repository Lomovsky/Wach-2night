//
//  SearchViewTableViewCellViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class SearchTableViewCellViewModel: SearchViewTableViewCellViewModelType {
    
    private var _film: Film
    
    var title: String {
        return _film.title
    }
    
    var poster: UIImage {
        return #imageLiteral(resourceName: "1024px-No_image_available.svg")
    }
    
    init(film: Film) {
        self._film = film
    }
    
}
