//
//  SearchTableViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 03.02.2021.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: Declarations
    let searchController = UISearchController(searchResultsController: nil)
    let cellID = "Cell"
//    static var filmResponse: FilmResponse? = nil
    static var films: [Film] = []
    var timer: Timer?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupTableView()

    }
    
    //MARK: viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        setupNavigationController()
        setupSearchBar()
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
    }
    
    private func setupSearchBar() {
        tabBarController?.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.backgroundColor = .clear
    }

 
}
