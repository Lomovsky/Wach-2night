//
//  SearchTableViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 03.02.2021.
//

import UIKit

final class SearchViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: Declarations
    var viewModel: SearchViewViewModelType? = SearchViewViewModel()
    var tableViewViewModel: SearchViewTableViewViewModelType? = SearchViewTableViewViewModel()
    weak var coordinator: MainCoordinator?
    
    //MARK: UIElements
    let shadowSubView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        view.addSubview(tableView)
        viewModel?.searchDelegate = self
        tableViewViewModel?.searchDelegate = self
        
        setupView()
        setupSearchBar()
        setupTableView()
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupNavigationController()
        
    }
    
    
    //MARK: SetupFuncs -
    private func setupView() {
        view.backgroundColor = .white
        
    }
    
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.visibleViewController?.title = "Поиск"
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = viewModel?.searchController
        viewModel?.searchController.searchBar.delegate = self
        viewModel?.searchController.obscuresBackgroundDuringPresentation = false
        viewModel?.searchController.searchBar.placeholder = "Введите название"
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellID)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.backgroundColor = .clear
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    deinit {
        tableViewViewModel?.removeAllObjects()
        print("\(self) was deallocated")
    }
    
}
