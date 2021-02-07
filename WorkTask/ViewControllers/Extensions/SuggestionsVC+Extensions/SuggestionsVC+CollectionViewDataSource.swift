//
//  ViewController + CollectionViewDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 10.12.2020.
//

import UIKit

extension SuggestionsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recommendationsCollectionView {
            return SuggestionsViewController.films.count

        } else if collectionView == self.genreCollectionView {
            return SuggestionsViewController.genres.count
        }
        return Int()
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.genreCollectionView {
            return CGSize(width: collectionView.frame.width * 0.35, height: collectionView.frame.height * 0.5)
            
        } else if collectionView == self.recommendationsCollectionView {
            return CGSize(width: view.frame.width - 125, height: collectionView.frame.size.height * 0.90)
        }
        return CGSize()
    }
    
    //    DistanceBetween Cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.recommendationsCollectionView {
            return 34
            
        } else if collectionView == self.genreCollectionView {
            return 10
            
        }
        return CGFloat()
    }
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.recommendationsCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsCollectionViewCell.reuseIdentifier,for: indexPath) as? RecommendationsCollectionViewCell {
                let film = SuggestionsViewController.films[indexPath.row]
                let defaultImage = #imageLiteral(resourceName: "1024px-No_image_available.svg")
                let poster = UIImage(data: film.poster!)
                let newPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: cell.frame.size.width,
                                                                                 height: cell.frame.size.height))
                DispatchQueue.main.async {
                    cell.configureCell(image: newPoster ?? defaultImage, title: film.title ?? "Неизвестно", originalTitle: film.originalTitle ?? "Неизвестно", releaseDate: film.releaseDate ?? "Неизвестно", rating: film.rating )
                }
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowRadius = 7
                cell.layer.shadowOpacity = 0.7
                cell.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
                cell.layer.masksToBounds = false
                return cell
            }
            
        } else if collectionView == self.genreCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.reuseIdentifier, for: indexPath) as? GenreCollectionViewCell {
                let genre = SuggestionsViewController.genres[indexPath.row]
                cell.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)
                cell.layer.cornerRadius = 10
                cell.configureTheCell(genreLabel: genre.name!)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.genreCollectionView {
            
        } else if collectionView == self.recommendationsCollectionView {
            let cell = collectionView.cellForItem(at: indexPath)
               let previewVC = PreviewViewController()

               UIView.animate(withDuration: 0.2,
                              animations: {
                               //Fade-out
                               cell?.alpha = 0.5
               }) { (completed) in
                   UIView.animate(withDuration: 0.2,
                                  animations: {
                                   //Fade-out
                                   cell?.alpha = 1
                   })
               }
            let film = SuggestionsViewController.films[indexPath.row]
            let poster = UIImage(data: film.poster!)
            let resizedPoster = poster?.resizeImageUsingVImage(size: CGSize.init(width: view.frame.width,
                                                                                 height: view.frame.height * 0.6))
            
            previewVC.imageView.image = resizedPoster
            previewVC.titleLabel.text = film.title
            previewVC.overviewText.text = film.overview
            navigationController?.present(previewVC, animated: true)
            
//               previewVC.yearLabel.text = film.releaseDate

            }
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
