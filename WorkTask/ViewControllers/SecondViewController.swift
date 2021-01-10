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
    
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        // Do any additional setup after loading the view.
    }
    
    //MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        setupImageView()
    }

    
    //MARK: Setup Funcs
    private func setupImageView() {
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.frame.size.width = view.frame.size.width
        imageView.frame.size.height = (imageView.image?.accessibilityFrame.height)!
    }
}
