//
//  ViewController + CollectionViewDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 10.12.2020.
//

import UIKit

extension SuggestionsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SuggestionsViewController.films.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 125, height: collectionView.frame.size.height * 0.8)
    }
    
    //    DistanceBetween Cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 34
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier,for: indexPath) as? CollectionViewCell {
            let film = SuggestionsViewController.films[indexPath.row]
            let defaultImage = #imageLiteral(resourceName: "1024px-No_image_available.svg")
            let poster = UIImage(data: film.poster!)
            let newPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: cell.frame.width,
                                                                             height: cell.frame.height / 1.6))
            DispatchQueue.main.async {
                cell.configureCell(image: newPoster ?? defaultImage, title: film.title ?? "Неизвестно", originalTitle: film.originalTitle ?? "Неизвестно", releaseDate: film.releaseDate ?? "Неизвестно", rating: film.rating )
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewVC = PreviewViewController()
        previewVC.modalPresentationStyle = .formSheet
        navigationController?.present(previewVC, animated: true)
        let film = SuggestionsViewController.films[indexPath.row]
        let poster = UIImage(data: film.poster!)
        let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: view.frame.width,
                                                                             height: view.frame.height * 0.6))
        
        previewVC.imageView.image = resizedPoster
        previewVC.titleLabel.text = film.title
        previewVC.yearLabel.text = film.releaseDate
       
    }
    
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //настройка ползунка при прокручивании
       if #available(iOS 13, *) {
           (scrollView.subviews[(scrollView.subviews.count - 1)].subviews[0]).backgroundColor = UIColor.white
            //verticalIndicator
            (scrollView.subviews[(scrollView.subviews.count - 2)].subviews[0]).isHidden = true
        //horizontalIndicator
        } else {
            if let verticalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 1)] as? UIImageView) {
               verticalIndicator.backgroundColor = UIColor.systemGray6
            }

            if let horizontalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 2)] as? UIImageView) {
                horizontalIndicator.isHidden = true
            }
        }

    }
    
}