//
//  SearchViewTableViewCellViewModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

class SearchTableViewCellViewModel: SearchViewTableViewCellViewModelType {
    
//    private var _film: Film 
    
    var title: String
    
    var poster: UIImage? {
        
        
        willSet {
            poster?.setValue(newValue, forKey: "image")
        }
//        return UIImage(named: "1024px-No_image_available.svg")
    }
    
    init(title: String, poster: UIImage) {
        self.title = title
        self.poster = poster
    }
    
}
