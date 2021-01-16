//
//  ViewController + CollectionViewDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 10.12.2020.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.films.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 125, height: collectionView.frame.size.height - 10)
    }
    
    //    DistanceBetween Cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 34
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier,for: indexPath) as? CollectionViewCell {
            let film = ViewController.films[indexPath.row]
            let defaultImage = #imageLiteral(resourceName: "1024px-No_image_available.svg")
            let poster = UIImage(data: film.poster!)
            let newPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: cell.frame.width,
                                                                             height: cell.frame.height / 1.6))
            DispatchQueue.main.async {
                cell.configureCell(image: newPoster ?? defaultImage, title: film.title ?? "Неизвестно", originalTitle: film.originalTitle ?? "Неизвестно", releaseDate: film.releaseDate ?? "Неизвестно", rating: film.rating )
            }
            cell.snapshotView(afterScreenUpdates: true)
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = .formSheet
        navigationController?.present(secondVC, animated: true)
        let film = ViewController.films[indexPath.row]
        let originalPosterImage = UIImage(data: film.originalSizedPoster!)!
        
        secondVC.imageView.image = originalPosterImage
        secondVC.titleLabel.text = film.title
        secondVC.yearLabel.text = film.releaseDate
       
    }
    
///    func scrollViewDidScroll(_ scrollView: UIScrollView) {
///        //настройка ползунка при прокручивании
///       if #available(iOS 13, *) {
///           (scrollView.subviews[(scrollView.subviews.count - 1)].subviews[0]).backgroundColor = UIColor.white //verticalIndicator
///            (scrollView.subviews[(scrollView.subviews.count - 2)].subviews[0]).backgroundColor = UIColor.white //horizontalIndicator
///        } else {
///            if let verticalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 1)] as? UIImageView) {
///               verticalIndicator.backgroundColor = UIColor.systemGray6
///            }
///
///            if let horizontalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 2)] as? UIImageView) {
///                horizontalIndicator.backgroundColor = UIColor.systemGray6
///            }
///        }
///
///    }
    
}
