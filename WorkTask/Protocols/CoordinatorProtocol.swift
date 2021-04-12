//
//  Coordinator.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 31.03.2021.
//

import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    var router: Router? { get set }
    func start()
    
}
