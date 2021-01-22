//
//  SearchViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 22.01.2021.
//

import UIKit

class SearchViewController: UITableViewController {
//MARK: Declarations
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
         self.clearsSelectionOnViewWillAppear = false

    }
    
//MARK: viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
        setupSearchBar()
    }

//MARK: SetupFuncs
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = false
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
    }
    
    

}
