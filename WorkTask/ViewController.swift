//
//  ViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.12.2020.
//

import UIKit

class ViewController: UIViewController {

    let stackView: UIStackView = {  // обьединяем labels
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let movieLabel: UILabel = { // первый label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondLabel: UILabel = { // второй label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

                
    }

    //MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(movieLabel)
        view.addSubview(secondLabel)
//        view.addSubview(collectionView)
        view.addSubview(stackView)
        
        
        setupStackView()
        setupLabels()
//        setupCollectionView()
    }
    
    private func setupStackView(){
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36.0).isActive = true
        stackView.addSubview(movieLabel)
        stackView.addSubview(secondLabel)
    }
    
    private func setupLabels() {
        movieLabel.text = "Movies"//настройка  первого лейбла
        movieLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0).isActive = true
        movieLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36.0).isActive = true
        movieLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        movieLabel.font = .systemFont(ofSize: 32)
        
        secondLabel.text  = "The library of my favourite movies"
        secondLabel.topAnchor.constraint(equalTo: movieLabel.topAnchor, constant: 60).isActive = true
        secondLabel.font = .systemFont(ofSize: 16)
        
        
 
    }

}

