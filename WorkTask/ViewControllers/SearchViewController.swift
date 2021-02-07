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
        view.addSubview(shadowSubView)
        view.addSubview(subview)
        view.addSubview(tableView)
        
        
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupShadowSubView()
        setupSubview()
        setupNavigationController()
        setupSearchBar()
        setupTableView()

    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    
    //MARK: SetupFuncs -
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)
    }
    
    private func setupShadowSubView() {
        shadowSubView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shadowSubView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        shadowSubView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        shadowSubView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        shadowSubView.layer.shadowColor = UIColor.black.cgColor
//        shadowSubView.layer.shadowRadius = 7
//        shadowSubView.layer.shadowOpacity = 0.7
//        shadowSubView.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
//        shadowSubView.layer.masksToBounds = false
        shadowSubView.addSubview(subview)
    }
    
    private func setupSubview() {
        subview.topAnchor.constraint(equalTo: shadowSubView.topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: shadowSubView.leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: shadowSubView.trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: shadowSubView.bottomAnchor).isActive = true
        subview.backgroundColor = UIColor(red: 0.96, green: 0.43, blue: 0.35, alpha: 1.00)
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.96, green: 0.43, blue: 0.35, alpha: 1.00)
        navigationController?.visibleViewController?.title = "Поиск"
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите название"
        searchController.searchBar.searchTextField.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        searchController.searchBar.searchTextField.tokenBackgroundColor = .white
        searchController.searchBar.searchTextField.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)
        searchController.isActive = true
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
    
    deinit {
        print("searchVC was dealloc")
    }
    
}
