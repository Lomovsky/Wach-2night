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
            
            let defaultImage = #imageLiteral(resourceName: "1024px-No_image_available.svg")
            let defaultImageData = defaultImage.pngData()
            
            DispatchQueue.main.async {
                cell.configureCell(image: film.poster ?? defaultImageData!, title: film.title ?? "Неизвестно", originalTitle: film.originalTitle ?? "Неизвестно", releaseDate: film.releaseDate ?? "Неизвестно", rating: film.rating )
                
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        secondVC.modalPresentationStyle = .formSheet
        navigationController?.present(secondVC, animated: true)
        let film = self.films[indexPath.row]
        secondVC.imageView.image = UIImage(data: film.poster!)
    }
    
}
