//
//  MainCoordinator.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 31.03.2021.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var router: Router?
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let vc = SuggestionsViewController()
        vc.coordinator = self
        router?.push(vc)
    }
    
    func showSearch() {
        let vc = SearchViewController()
        vc.coordinator = self
        router?.push(vc)
    }
    
    func showPreview(suggestionsCollectionViewViewModel: SuggestionsCollectionViewViewModelType?,
                     favoriteCollectionViewViewModel: FavoritesCollectionViewViewModelType?, selfDelegate: SuggestionsDelegate, action: Action) {
        
        let previewVC = PreviewViewController()
        previewVC.coordinator = self
        
        switch action {
        case .save:
            previewVC.viewModel = suggestionsCollectionViewViewModel?.viewModelForSelectedRow()
            router?.push(previewVC, animated: true, completion: {
                previewVC.viewModel?.suggestionsDelegate = selfDelegate
                
                previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.addToFavorites),
                                                   for: .touchUpInside)
                previewVC.favoriteButton.setTitle("Добавить в избранное", for: .normal)
            })
            
        default:
            previewVC.viewModel?.suggestionsDelegate = selfDelegate
            previewVC.viewModel = favoriteCollectionViewViewModel?.viewModelForSelectedRow()
            router?.present(previewVC, animated: true, completion: {
                previewVC.viewModel?.suggestionsDelegate = selfDelegate
                
                previewVC.favoriteButton.addTarget(previewVC.self, action: #selector(previewVC.deleteFromFavorites), for: .touchUpInside)
                previewVC.favoriteButton.setTitle("Удалить из избранного", for: .normal)
            })
            
        }
    }
    
    func presentPreviewFromSearch(viewModel: PreviewViewModelType) {
        let vc = PreviewViewController()
        vc.coordinator = self
        
        vc.viewModel = viewModel
        router?.present(vc)
    }
    
    func showMoreVC() {
        let vc = GenreViewController()
        vc.coordinator = self
        vc.navigationController?.visibleViewController?.title = "Рекомендации"
        router?.present(vc)
    }
}
