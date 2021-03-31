//
//  MainCoordinator.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 31.03.2021.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SuggestionsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showSearch() {
        let vc = SearchViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showPreview(suggestionsCollectionViewViewModel: SuggestionsCollectionViewViewModelType?,
                     favoriteCollectionViewViewModel: FavoritesCollectionViewViewModelType?, selfDelegate: SuggestionsDelegate, action: Action) {
        
        let vc = SuggestionsViewController()
        let previewVC = PreviewViewController()
        vc.coordinator = self
        previewVC.coordinator = self
        
        switch action {
        case .save:
            previewVC.viewModel = suggestionsCollectionViewViewModel?.viewModelForSelectedRow()
            navigationController.present(previewVC, animated: true) {
                previewVC.viewModel?.suggestionsDelegate = selfDelegate
                
                previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.addToFavorites),
                                                   for: .touchUpInside)
                previewVC.favoriteButton.setTitle("Добавить в избранное", for: .normal)
            }
            
        default:
            previewVC.viewModel?.suggestionsDelegate = selfDelegate
            previewVC.viewModel = favoriteCollectionViewViewModel?.viewModelForSelectedRow()
            navigationController.present(previewVC, animated: true) {
                previewVC.viewModel?.suggestionsDelegate = selfDelegate
                
                previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.deleteFromFavorites), for: .touchUpInside)
                previewVC.favoriteButton.setTitle("Удалить из избранного", for: .normal)
            }
        }
    }
}
