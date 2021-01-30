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
