//
//  ViewControllerHelperFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 15.01.2021.
//

import UIKit

extension SuggestionsViewController {
    
    @objc final func showSearch() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc final func refresh(_ sender: AnyObject) {
        recommendationsCollectionView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.downloadFilms(condition: .update)
        
    }
    
    func animateCell(cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.2,
                       animations: {
                        //Fade-out
                        cell.alpha = 0.5
                       }) { (completed) in
            UIView.animate(withDuration: 0.2,
                           animations: {
                            //Fade-out
                            cell.alpha = 1
                           })
        }
    }
    
    @objc final func showMore() {
        let vc = GenreViewController()
        vc.navigationController?.visibleViewController?.title = "Рекомендации"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


