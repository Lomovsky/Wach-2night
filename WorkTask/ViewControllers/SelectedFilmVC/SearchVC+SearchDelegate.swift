//
//  SearchVC+SearchDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import UIKit

extension SearchViewController: SearchDelegate {
    
    func updateUI() {
        tableView.reloadData()
        print("UPDATED")
    }
    
}
