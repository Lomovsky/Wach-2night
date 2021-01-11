//
//  SecondViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 17.12.2020.
//

import UIKit

class SecondViewController: UIViewController {
    
    //MARK: Declarations
    let imageView: UIImageView = {
       let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        // Do any additional setup after loading the view.
    }
    
    //MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        setupImageView()
        setupTitleLabel()
    }

    
    //MARK: Setup Funcs
    private func setupImageView() {
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.frame.size.width = (imageView.image?.size.width)!
        imageView.contentMode = .scaleToFill
//        imageView.clipsToBounds = true
        imageView.frame.size.height = (view.frame.height) / 1.5
    }
    
    private func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
    }
}
