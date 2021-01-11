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
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overviewTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(overviewTF)
        view.addSubview(overviewLabel)
//        view.addSubview(scrollView)
    }
    
    //MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        setupImageView()
        setupTitleLabel()
        setupOverviewLabel()
        setupOverviewTextField()
//        setupNavigationController()
//        setupScrollView()
    }

    
    //MARK: Setup Funcs
    
    private func setupNavigationController() {
//        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupImageView() {
        let cornerRadius: CGFloat = 10.0
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        imageView.frame.size.height = (imageView.image?.size.height) ?? (view.frame.height) / 2
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 7
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
        
        let cgPath = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius)).cgPath
        imageView.layer.shadowPath = cgPath
        
    }
    
    private func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func setupOverviewLabel() {
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        overviewLabel.text = "Сюжет:"
        overviewLabel.font = .italicSystemFont(ofSize: 20)
        overviewLabel.textColor = .systemGray
    }
    
    private func setupOverviewTextField() {
        overviewTF.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10).isActive = true
        overviewTF.frame.size.width = view.frame.size.width - 5
        overviewTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        overviewTF.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        overviewTF.allowsEditingTextAttributes = false
        overviewTF.isUserInteractionEnabled = false
        
    }
    
    private func setupScrollView() {
//        scrollView.frame.size.height = view.frame.size.height
//        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//        scrollView.addSubview(imageView)
//        scrollView.addSubview(titleLabel)
//        scrollView.addSubview(overviewLabel)
//        scrollView.addSubview(overviewTF)
    }
}
