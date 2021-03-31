//
//  SearchVC+TableViewDataSource.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 03.02.2021.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Table view data source    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewViewModel?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellID, for: indexPath) as! TableViewCell
        let cellViewModel = tableViewViewModel?.cellViewModel(forIndexPath: indexPath, cell: cell)
        cell.viewModel = cellViewModel
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 20
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewViewModel?.selectRow(atIndexPath: indexPath)
        guard let vm = tableViewViewModel?.viewModelForSelectedRow() else { return }
        coordinator?.presentPreviewFromSearch(viewModel: vm)

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.init(view.frame.size.height * 0.065)
    }
}
