//
//  MainRouter.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 12.04.2021.
//

import UIKit

//MARK: MainRouter
final class Router: Routable {
    
    let rootController: UINavigationController
    private var completions: [UIViewController : CompletionBlock]
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController.present(controller, animated: animated, completion: nil)
        
    }
    
    func present(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {
        guard let controller = module?.toPresent() else { return }
        if let completion = completion {
            completions[controller] = completion
        }
        rootController.pushViewController(controller, animated: animated)
    }
    
    func push(_ module: Presentable?) {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {
        guard
            let controller = module?.toPresent()
        else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        rootController.pushViewController(controller, animated: animated)
        
    }
    
    func popModule() {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        rootController.popViewController(animated: animated)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: CompletionBlock?) {
        rootController.dismiss(animated: animated, completion: completion)
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module?.toPresent(), hideBar: false)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController.setViewControllers([controller], animated: false)
        rootController.isNavigationBarHidden = hideBar
        UIApplication.shared.windows.first?.rootViewController = rootController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func popToRootModule(animated: Bool) {
        rootController.popToRootViewController(animated: animated)
    }
    
}

