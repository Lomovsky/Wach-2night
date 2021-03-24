//
//  SearchViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

protocol SearchViewViewModelType {
    
    var films: [Film] { get set }
    var searchDelegate: SearchDelegate? { get set }
    func search(url: String)
    
}

