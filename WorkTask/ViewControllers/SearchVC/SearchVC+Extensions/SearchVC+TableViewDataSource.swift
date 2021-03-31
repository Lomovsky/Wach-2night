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
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel!.cellID, for: indexPath) as! TableViewCell
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
//        let previewVC = PreviewViewController()
//        tableViewViewModel?.selectRow(atIndexPath: indexPath)
//        let model = tableViewViewModel?.viewModelForSelectedRow()
//        previewVC.viewModel = model
//        navigationController?.present(previewVC, animated: true, completion: nil)
        
    }
}
