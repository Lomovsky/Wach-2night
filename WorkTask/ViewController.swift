//
//  ViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.12.2020.
//

import UIKit



class ViewController: UIViewController {
    

    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .init(x: 0, y: 178, width: 300, height: 473), collectionViewLayout: UICollectionViewFlowLayout())

        
        return collection
        
    }()

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
        
        view.addSubview(movieLabel)
        view.addSubview(secondLabel)
        view.addSubview(collectionView)
        view.addSubview(stackView)

       
                
    }

    //MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {


        setupStackView()
        setupLabels()

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
    private func setupCollectionView() {
//        collectionView.isPagingEnabled = true
        collectionView.frame.size.width = view.frame.size.width
        collectionView.frame.size.height = view.frame.size.height
        
        
    }

}
extension ViewController: UICollectionViewDelegate {
    
    
}


