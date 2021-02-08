//
//  ViewController + CollectionViewDelegate.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 10.12.2020.
//

import UIKit

extension SuggestionsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: numberOfItemsInSection-
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recommendationsCollectionView {
            return SuggestionsViewController.films.count
            
        } else if collectionView == self.genreCollectionView {
            return SuggestionsViewController.genres.count
            
        } else if collectionView == self.favouriteFilmsCollectionView {
            
            if SuggestionsViewController.favouriteFilms.isEmpty {
                return 3
            }
            return SuggestionsViewController.favouriteFilms.count
        }
        return Int()
    }
    
    //MARK: sizeForItemAt -
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.genreCollectionView {
            return CGSize(width: collectionView.frame.width * 0.35, height: collectionView.frame.height * 0.5)
            
        } else if collectionView == self.recommendationsCollectionView {
            return CGSize(width: view.frame.width - 125, height: collectionView.frame.size.height * 0.90)
            
        } else if collectionView == self.favouriteFilmsCollectionView {
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
            
        } else if collectionView == self.favouriteFilmsCollectionView {
            return 34
            
        }
        return CGFloat()
    }
    
    //MARK: cellForItemAt -
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.recommendationsCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsCollectionViewCell.reuseIdentifier,for: indexPath) as? RecommendationsCollectionViewCell {
                
                let film = SuggestionsViewController.films[indexPath.row]
                if let poster = film.poster {
                    if let posterImage = UIImage(data: poster) {
                        let newPoster = posterImage.resizeImageUsingVImage(size: CGSize.init(width: cell.frame.size.width,
                                                                                             height: cell.frame.size.height))
                        cell.imageView.image = newPoster
                        cell.layer.shadowColor = UIColor.black.cgColor
                        cell.layer.shadowRadius = 5
                        cell.layer.shadowOpacity = 0.4
                        cell.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
                        cell.layer.masksToBounds = false
                        return cell
                    }
                    
                } else {
                    cell.imageView.image = #imageLiteral(resourceName: "1024px-No_image_available.svg")
                    cell.layer.shadowColor = UIColor.black.cgColor
                    cell.layer.shadowRadius = 5
                    cell.layer.shadowOpacity = 0.4
                    cell.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
                    cell.layer.masksToBounds = false
                    return cell
                }
                
                
            }
            
        } else if collectionView == self.genreCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.reuseIdentifier, for: indexPath) as? GenreCollectionViewCell {
                
                let genre = SuggestionsViewController.genres[indexPath.row]
                cell.backgroundColor = .systemGray6
                cell.layer.cornerRadius = 12
                cell.genreLabel.text = genre.name?.capitalized
                return cell
                
            }
            
        } else if collectionView == self.favouriteFilmsCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteFilmsCollectionViewCell.reuseIdentifier, for: indexPath) as? FavouriteFilmsCollectionViewCell {
                
                if SuggestionsViewController.favouriteFilms.isEmpty {
                    cell.backgroundColor = .systemGray6
                    cell.layer.cornerRadius = 10
                    cell.imagePlaceholder.text = "Нет фильма"
                    cell.imagePlaceholder.isHidden = false
                    return cell
                    
                } else {
                    let film = SuggestionsViewController.favouriteFilms.reversed()[indexPath.row]
                    if let poster = film.poster {
                        if let posterImage = UIImage(data: poster) {
                            let newPoster = posterImage.resizeImageUsingVImage(size: CGSize.init(width: cell.frame.size.width,
                                                                                                 height: cell.frame.size.height))
                            cell.imageView.image = newPoster
                            return cell
                        }
                    } else {
                        cell.imageView.image = #imageLiteral(resourceName: "1024px-No_image_available.svg")
                        return cell
                    }
                }
            }
        }
        return UICollectionViewCell()
    }
    
    //MARK: didSelectItemAt-
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.genreCollectionView {
            
        } else if collectionView == self.recommendationsCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) else { return }
            let previewVC = PreviewViewController()
            let film = SuggestionsViewController.films[indexPath.row]
            if let poster = film.poster {
                if let posterImage = UIImage(data: poster) {
                    let resizedPoster = posterImage.resizeImageUsingVImage(size: CGSize.init(width: view.frame.width,
                                                                                             height: view.frame.height * 0.6))
                    animateCell(cell: cell)
                    previewVC.imageView.image = resizedPoster
                    previewVC.titleLabel.text = film.title
                    previewVC.overviewText.text = film.overview
                    previewVC.film = film
                    navigationController?.present(previewVC, animated: true, completion: {
                        previewVC.favoriteButton.setTitle("Добавить в избранное", for: .normal)
                        previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.addToFavorites), for: .touchUpInside)
                    })
                } else {
                    
                    previewVC.imageView.image = #imageLiteral(resourceName: "1024px-No_image_available.svg")
                    previewVC.titleLabel.text = film.title
                    previewVC.overviewText.text = film.overview
                    previewVC.film = film
                    navigationController?.present(previewVC, animated: true, completion: {
                        previewVC.favoriteButton.setTitle("Добавить в избранное", for: .normal)
                        previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.addToFavorites), for: .touchUpInside)
                        
                    })
                }
            }
        } else if collectionView == self.favouriteFilmsCollectionView {
            if SuggestionsViewController.favouriteFilms.isEmpty {
                
            } else {
                guard let cell = collectionView.cellForItem(at: indexPath) else { return }
                let previewVC = PreviewViewController()
                let film = SuggestionsViewController.favouriteFilms.reversed()[indexPath.row]
                if let poster = film.poster {
                    guard let posterImage = UIImage(data: poster) else { return }
                    let resizedPoster = posterImage.resizeImageUsingVImage(size: CGSize.init(width: view.frame.width,
                                                                                         height: view.frame.height * 0.6))
                    
                    animateCell(cell: cell)
                    previewVC.imageView.image = resizedPoster
                    previewVC.titleLabel.text = film.title
                    previewVC.overviewText.text = film.overview
                    self.navigationController?.present(previewVC, animated: true, completion: {
                        previewVC.favoriteButton.setTitle("Удалить из избранного", for: .normal)
                        previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.deleteFromFavorites), for: .touchUpInside)
                    })
                    
                } else {
                    animateCell(cell: cell)
                    previewVC.imageView.image = #imageLiteral(resourceName: "1024px-No_image_available.svg")
                    previewVC.titleLabel.text = film.title
                    previewVC.overviewText.text = film.overview
                    self.navigationController?.present(previewVC, animated: true, completion: {
                        previewVC.favoriteButton.setTitle("Удалить из избранного", for: .normal)
                        previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.deleteFromFavorites), for: .touchUpInside)
                    })
                }

            }
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
