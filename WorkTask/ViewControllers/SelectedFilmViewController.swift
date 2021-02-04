//
//  SearchFilmDetailsViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 04.02.2021.
//

import UIKit

class SelectedFilmViewController: UIViewController {
    //MARK: Declarations
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let imageStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    //MARK: viewDidLoad & viewWillAppear -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageStack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupNavigationController()
        setupImageStack()
    }
    //MARK: SetupFuncs -
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.93, alpha: 1.00)
    }
    
    private func setupNavigationController() {
        tabBarController?.navigationController?.navigationBar.isHidden = false
        tabBarController?.navigationItem.searchController = nil
    }
    
    private func setupImageStack() {
        let cornerRadius: CGFloat = 10.0
        let cgPath = UIBezierPath(roundedRect: imageStack.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius)).cgPath
        imageStack.layer.shadowColor = UIColor.black.cgColor
        imageStack.layer.shadowRadius = 7
        imageStack.layer.shadowOpacity = 0.7
        imageStack.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
        imageStack.layer.shadowPath = cgPath
        
        imageStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageStack.frame.size.height = view.frame.height / 3
    }
    
    
}
