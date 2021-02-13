//
//  SecondViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 17.12.2020.
//

import UIKit

class PreviewViewController: UIViewController {
    let coreDataManager = CoreDataManager()
    var film: CurrentFilm? = nil
    
    //MARK: Declarations
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    let containerView: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    let overviewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let overviewText: UILabel = {
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.sizeToFit()
        return tf
    }()

    
    
    //MARK: viewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(stackView)
        view.addSubview(imageView)
        view.addSubview(favoriteButton)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(overviewBackground)
        view.addSubview(overviewText)
        
        setupView()
        setupScrollView()
        setupStackView()
        setupImageView()
        setupFavoriteButton()
        setupTitleLabel()
        setupOverviewLabel()
        setupOverviewBackground()
        setupOverviewText()
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
       
    }


    
    deinit {
        print("PreviewVC was dealocated")
    }
    
}
