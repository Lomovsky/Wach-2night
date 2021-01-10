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
            let film = self.films[indexPath.row]
            
            cell.configureCell(image: film.poster!, title: film.title!, originalTitle: film.originalTitle!)
//            cell.frame.size.width = (view.frame.size.width) / 1.8
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(secondVC, animated: true)
    }
    
}
