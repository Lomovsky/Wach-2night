//
//  AbstractFactory.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 19.03.2021.
//

import UIKit

struct PreviewViewControllerFactory {
    
    let filmPoster: UIImage
    let filmTitle: String
    let filmOverview: String
    
    
    func setupViewController() -> PreviewViewController {
        
        return PreviewViewController(poster: filmPoster, filmTitle: filmTitle, filmOverview: filmOverview)
    }
}
