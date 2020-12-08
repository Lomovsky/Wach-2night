//
//  ViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.12.2020.
//

import UIKit

var images = ["hanSolo","day", "Night", "day", "Night",]

class ViewController: UIViewController, UICollectionViewDelegate {
    
    //MARK: Setting up UI elements
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .init(x: 0, y: 178, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv .register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellReuseIdentifier")
        return cv
        
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
        collectionView.delegate = self
        collectionView.dataSource = self
        registerNib()
    }
    
    //MARK: ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        setupStackView()
        setupLabels()
        setupCollectionView()
        
    }
    
    //MARK:Set up funcs
    func registerNib() {
        let nib = UINib(nibName: CollectionViewCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 226, height: 354)
        }
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
        collectionView.frame.size.width = view.frame.width
        collectionView.frame.size.height = ((view.frame.height) / 0.5)
        collectionView.backgroundColor = .white
        collectionView.accessibilityScroll(.left)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 55) // отступ первой и последней ячейки
        
    }
    
    

    
    
}
//MARK: UICollectionViewDataSource extencion for ViewController
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count // кол ячеек в этой строке
        
    }
    //   все та же настройка размеров
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width , height: collectionView.frame.size.height - 5)
        
    }
    
    //    расстояние между ячейками
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 34
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier,for: indexPath) as? CollectionViewCell {
            let image = images[indexPath.row]
            let name = images[indexPath.row]
            cell.configureCell(image: image, label: name)
            
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}




