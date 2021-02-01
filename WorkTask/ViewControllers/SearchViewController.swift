//
//  SearchViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.01.2021.
//

import UIKit

class SearchViewController: UIViewController {
//MARK: Declarations
    let searchController = UISearchController(searchResultsController: nil)
    let searchURL = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=\(searchLanguage)&query=\(searchRequest)&page=1&include_adult=true"
    
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//MARK: viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        setupNavigationController()

    }

//MARK: SetupFuncs
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 0.95, green: 0.98, blue: 0.93, alpha: 1.00).cgColor
        let colorBottom = UIColor(red: 0.68, green: 0.76, blue: 0.81, alpha: 1.00).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupNavigationController() {
        tabBarController?.navigationController?.navigationBar.isHidden = false
//        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(someFnc))
        tabBarController?.navigationItem.searchController = searchController
        
    }
    
 
    @objc func someFnc() {
        
    }
    

}
