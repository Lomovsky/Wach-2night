//
//  TabBarController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 16.01.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let suggestionsVC = SuggestionsViewController()
        suggestionsVC.tabBarItem = UITabBarItem(title: "Рекомендации",
                                                image: UIImage(systemName: "star.fill"), tag: 0)
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Поиск по названию",
                                           image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let tabBarList = [suggestionsVC, searchVC]
        viewControllers = tabBarList
    }
    
    
}

extension TabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          return true // Make sure you want this as false
        }

        if fromView != toView {
          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }

        return true
    }
}
