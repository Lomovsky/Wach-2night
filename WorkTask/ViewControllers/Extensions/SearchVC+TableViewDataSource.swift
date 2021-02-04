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
        
        return  self.filmResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let film = self.filmResponse?.results[indexPath.row]
        cell.textLabel?.text = film?.title
        
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = self.filmResponse?.results[indexPath.row]
        let selectedFilmVC = SelectedFilmViewController()
        let posterUrlString = imagePath + (film?.posterPath)!
        guard let posterURL = URL(string: posterUrlString) else { return }
        DispatchQueue.global(qos: .utility).async {
            let imageData = try? Data(contentsOf: posterURL)
            let poster = UIImage(data: imageData!)
            selectedFilmVC.posterImage = poster!
        }

        self.navigationController?.pushViewController(selectedFilmVC, animated: true)
    }
    
}
