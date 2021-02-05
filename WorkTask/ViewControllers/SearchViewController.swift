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
    var filmResponse: FilmResponse? = nil
    var timer: Timer?
    
    
    //MARK: UIElements
    let subview: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: viewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(subview)
        view.addSubview(tableView)
        
        
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupSubview()
        setupNavigationController()
        setupSearchBar()
        setupTableView()

    }
    
    //MARK: SetupFuncs -

    private func setupView() {
        view.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)
    }
    
    private func setupSubview() {
        subview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        subview.backgroundColor = UIColor(red: 0.96, green: 0.43, blue: 0.35, alpha: 1.00)
    }
    
    private func setupNavigationController() {
        tabBarController?.navigationController?.navigationBar.isHidden = false
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.visibleViewController?.title = "Поиск"
        
    }
    
    private func setupSearchBar() {
        tabBarController?.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите название"
        searchController.searchBar.tintColor = .white
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
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
}
