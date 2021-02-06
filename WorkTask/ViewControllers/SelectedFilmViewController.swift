//
//  SearchFilmDetailsViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 04.02.2021.
//

import UIKit

class SelectedFilmViewController: UIViewController {
    //MARK: Declarations
    let shadowSubview: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    //MARK: viewDidLoad & viewWillAppear -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shadowSubview)
        view.addSubview(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupNavigationController()
        setupShadowSubview()
        setupImageView()
    }
    //MARK: SetupFuncs -
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor(red: 0.96, green: 0.43, blue: 0.35, alpha: 1.00)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)
        
    }
    
    private func setupShadowSubview() {
        shadowSubview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        shadowSubview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        shadowSubview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        shadowSubview.frame.size.height = imageView.image!.accessibilityFrame.height
        shadowSubview.layer.shadowRadius = 7
        shadowSubview.layer.shadowOpacity = 0.7
        shadowSubview.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
        shadowSubview.layer.masksToBounds = false
        shadowSubview.addSubview(imageView)

    }
    
    private func setupImageView() {
        imageView.topAnchor.constraint(equalTo: shadowSubview.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: shadowSubview.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: shadowSubview.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: shadowSubview.heightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
    }

    deinit {
        print("selectedFilmVC was dealocated")
    }
    
}
