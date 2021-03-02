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
        
        return self.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let itemNumber = NSNumber(value: indexPath.item)
        let film = self.films[indexPath.row]
        
        cell.imageView?.image = #imageLiteral(resourceName: "1024px-No_image_available.svg")
        cell.textLabel?.text = film.title
        
        if let posterPath = film.posterPath {
            let posterUrlString = imagePath + posterPath
            let posterURL = URL(string: posterUrlString)
            
            if let cashedImage = self.cache.object(forKey: itemNumber) {
                cell.imageView?.image = cashedImage
                cell.imageView?.clipsToBounds =  true
                cell.imageView?.layer.cornerRadius = 20
            } else {
                DispatchQueue.global(qos: .utility).async {
                    let imageData = try? Data(contentsOf: posterURL!)
                    let poster = UIImage(data: imageData!)
                    let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: 50, height: 50))
                    DispatchQueue.main.async {
                        cell.imageView?.image = resizedPoster
                        cell.imageView?.clipsToBounds =  true
                        cell.imageView?.layer.cornerRadius = 20
                        self.cache.setObject(resizedPoster!, forKey: itemNumber)
                    }
                }
            }
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "1024px-No_image_available.svg")
            cell.textLabel?.text = film.title
            cell.imageView?.clipsToBounds =  true
            cell.imageView?.layer.cornerRadius = 20
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = self.films[indexPath.row] //проверить
        let selectedFilmVC = SelectedFilmViewController()
        let posterUrlString = imagePath + (film.posterPath)!
        guard let posterURL = URL(string: posterUrlString) else { return }
        DispatchQueue.global(qos: .utility).async {
            let imageData = try? Data(contentsOf: posterURL)
            let poster = UIImage(data: imageData!) //проверить
            
            //TODO: work with GSD
            DispatchQueue.main.async {
                let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: 200, height: 200))
                selectedFilmVC.imageView.image = resizedPoster
                self.navigationController?.pushViewController(selectedFilmVC, animated: true)
                
            }
        }
    }
}
