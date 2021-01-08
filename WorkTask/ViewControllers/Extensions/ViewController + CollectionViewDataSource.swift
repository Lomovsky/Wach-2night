//
//  ViewController + CollectionViewDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 10.12.2020.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.films.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width , height: collectionView.frame.size.height - 5)
    }
    
    //    DistanceBetween Cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 34
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier,for: indexPath) as? CollectionViewCell {
            let film = filmResponse?.results[indexPath.row]
            
            
            DispatchQueue.global().async {
                guard let secondPath = film?.posterPath else { return }
                let imageURLString = imagePath + secondPath
                guard let imageURL = URL(string: imageURLString) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                self.save(film!.title, filmOriginalTitle: film!.originalTitle, filmPoster: imageData)
            }
            
            DispatchQueue.main.async {
                let film = self.films[indexPath.row]
                cell.configureCell(image: film.poster!, title: film.title ?? "errorTitle", writer: film.title ?? "error title", genre: film.originalTitle ?? "error origTitle")
            }
            
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(secondVC, animated: true)
    }
    
}
