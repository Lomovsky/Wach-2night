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
        
        return tableViewViewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellID, for: indexPath) as! TableViewCell
        
//        let itemNumber = NSNumber(value: indexPath.item)
        let cellViewModel = tableViewViewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        
        
        
//        let film = self.viewModel.films[indexPath.row]
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = SearchViewViewModel.films[indexPath.row]
        guard let posterPath = film.posterPath else { return }
        let posterUrlString = imagePath + posterPath
        guard let posterURL = URL(string: posterUrlString) else { return }
        DispatchQueue.global(qos: .utility).async {
            guard let imageData = try? Data(contentsOf: posterURL) else { return }
            let poster = UIImage(data: imageData)
            
            //TODO: work with GSD
            DispatchQueue.main.async {
                let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: self.view.frame.width,
                                                                                     height: self.view.frame.height * 0.6))
                
//                let previewVC = PreviewViewController(poster: resizedPoster ?? #imageLiteral(resourceName: "1024px-No_image_available.svg"), filmTitle: film.title, filmOverview: film.overview)
//                self.navigationController?.present(previewVC, animated: true, completion: {
//                    previewVC.favoriteButton.setTitle("Добавить в избранное", for: .normal)
//                    previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.addToFavorites), for: .touchUpInside)
//                })
            }
        }
    }
}
