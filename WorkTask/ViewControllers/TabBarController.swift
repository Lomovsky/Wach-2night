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
        suggestionsVC.tabBarItem = UITabBarItem(title: "Рекомендации", image: UIImage(systemName: "star.fill"), tag: 0)
        
        let tabBarList = [suggestionsVC]
        
        viewControllers = tabBarList
    }
}
