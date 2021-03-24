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
        switch collectionView {
        case recommendationsCollectionView:
            return suggestionsCollectionViewViewModel.numberOfItems()
            
        case genreCollectionView:
            return genresCollectionViewViewModel.numberOfItems()
            
        case favouriteFilmsCollectionView:
            if favoritesCollectionViewViewModel.numberOfItems() == 0 {
                return 3
            } else {
                return favoritesCollectionViewViewModel.numberOfItems()
            }
            
        default: return 0
            
        }
    }
    
    //MARK: sizeForItemAt -
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.genreCollectionView:
            return CGSize(width: collectionView.frame.width * 0.35, height: collectionView.frame.height * 0.5)
            
        case self.recommendationsCollectionView:
            return CGSize(width: view.frame.width - 125, height: collectionView.frame.size.height * 0.90)
            
        case self.favouriteFilmsCollectionView:
            return CGSize(width: view.frame.width - 125, height: collectionView.frame.size.height * 0.90)
            
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    //    DistanceBetween Cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case recommendationsCollectionView:
            return 34
            
        case genreCollectionView:
            return 10
            
        case favouriteFilmsCollectionView:
            return 34
            
        default:
            return 0
        }
    }
    
    //MARK: cellForItemAt -
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case recommendationsCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsCollectionViewCell.reuseIdentifier,for: indexPath) as? RecommendationsCollectionViewCell {
                
                let cellViewModel = suggestionsCollectionViewViewModel.cellViewModel(forIndexPath: indexPath)
                cell.viewModel = cellViewModel
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowRadius = 5
                cell.layer.shadowOpacity = 0.4
                cell.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
                cell.layer.masksToBounds = false
                return cell
            }
            
        case genreCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.reuseIdentifier, for: indexPath) as? GenreCollectionViewCell {
                
                let cellViewModel = genresCollectionViewViewModel.cellViewModel(forIndexPath: indexPath)
                cell.backgroundColor = .systemGray6
                cell.layer.cornerRadius = 12
                cell.viewModel = cellViewModel
                return cell
            }
            
        case favouriteFilmsCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteFilmsCollectionViewCell.reuseIdentifier, for: indexPath) as? FavouriteFilmsCollectionViewCell {
                
                if favoritesCollectionViewViewModel.numberOfItems() == 0 {
                    cell.backgroundColor = .systemGray6
                    cell.imageView.isHidden = true
                    cell.layer.cornerRadius = 10
                    cell.imagePlaceholder.text = "Нет фильма"
                    cell.imagePlaceholder.isHidden = false
                    return cell
                    
                } else {
                    let cellViewModel = favoritesCollectionViewViewModel.cellViewModel(forIndexPath: indexPath)
                    cell.viewModel = cellViewModel
                    return cell
                }
            }
            
        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
    
    //MARK: didSelectItemAt-
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case genreCollectionView:
            break
            
        case recommendationsCollectionView:
            guard let cell = collectionView.cellForItem(at: indexPath) else { return }
            animateCell(cell: cell)
            suggestionsCollectionViewViewModel.selectRow(atIndexPath: indexPath)
            let previewVC = PreviewViewController()
            previewVC.viewModel = suggestionsCollectionViewViewModel.viewModelForSelectedRow()
            previewVC.viewModel?.suggestionsDelegate = self
            previewVC.viewModel?.filmToAdd = suggestionsCollectionViewViewModel.filmToSave(indexPath: indexPath)
//            previewVC.viewModel?.filmToDelete = suggestionsCollectionViewViewModel.filmToDelete(indexPath: indexPath)
            navigationController?.present(previewVC, animated: true, completion: {
                previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.addToFavorites),
                                                   for: .touchUpInside)
                previewVC.favoriteButton.setTitle("Добавить в избранное", for: .normal)
            })

            
        case favouriteFilmsCollectionView:
            if suggestionsCollectionViewViewModel.numberOfItems() == 0 {
                
            } else {
                
                guard let cell = collectionView.cellForItem(at: indexPath) else { return }
                animateCell(cell: cell)
                suggestionsCollectionViewViewModel.selectRow(atIndexPath: indexPath)
                let previewVC = PreviewViewController()
                previewVC.viewModel = suggestionsCollectionViewViewModel.viewModelForSelectedRow()
                previewVC.viewModel?.suggestionsDelegate = self
                previewVC.viewModel?.filmToDelete = suggestionsCollectionViewViewModel.filmToDelete(indexPath: indexPath)
                navigationController?.present(previewVC, animated: true, completion: {
                    previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.deleteFromFavorites), for: .touchUpInside)
                    previewVC.favoriteButton.setTitle("Удалить из избранного", for: .normal)
                })
            }
        
        default:
            break
            
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
