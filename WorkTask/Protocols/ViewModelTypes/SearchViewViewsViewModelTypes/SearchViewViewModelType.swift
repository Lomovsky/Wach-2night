//
//  SearchViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

protocol SearchViewViewModelType: class {
    
    var films: [Film] { get set }
    var searchDelegate: SearchDelegate? { get set }
    var cache: NSCache<NSNumber, UIImage> { get set }
    var searchController: UISearchController { get }
    var timer: Timer? { get set }
    
    func search(url: String)
    func removeAllObjects()
    
}

