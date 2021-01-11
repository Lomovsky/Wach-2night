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
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    


    
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(infoButton)

    }
    
    //MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        setupImageView()
        setupNavigationController()
        setupViewController()
        setupInfoButton()
    }

    
    //MARK: Setup Funcs
    private func setupViewController() {
        view.backgroundColor = UIColor(red: 0.75, green: 0.83, blue: 0.95, alpha: 1.00)
    }
    
    private func setupNavigationController() {

    }
    
    private func setupImageView() {
        let cornerRadius: CGFloat = 10.0
        


        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.frame.size.height = (imageView.image?.size.height) ?? (view.frame.height) / 2
        imageView.frame.size.width = (imageView.image?.size.width) ?? (view.frame.width)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 7
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
        imageView.layer.cornerRadius = 10
        
        let cgPath = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius)).cgPath
        imageView.layer.shadowPath = cgPath
        
    }
    
    private func setupInfoButton() {
        infoButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        infoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        infoButton.frame.size.height = 30
        infoButton.backgroundColor = .systemBlue
        infoButton.layer.cornerRadius = 10
        infoButton.setTitle("Детальная информация", for: .normal)
        infoButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        dismiss(animated: true)
    }

}
