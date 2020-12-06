//
//  ViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.12.2020.
//

import UIKit

var images = ["Night", "day"]

class ViewController: UIViewController {
    
  


    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
//        let collection = UICollectionView(frame: .init(x: 0, y: 178, width: 300, height: 473), collectionViewLayout: UICollectionViewFlowLayout())
        

        
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
    func registerNib() {
        let nib = UINib(nibName: CollectionViewCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
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
//        collectionView.isPagingEnabled = true
        collectionView.frame.size.width = view.frame.size.width
        collectionView.frame.size.height = view.frame.size.height
        collectionView.backgroundColor = .white
        collectionView.accessibilityScroll(.left)
        
        
    }

}
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        images.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier,for: indexPath) as? CollectionViewCell {
                let image = images[indexPath.row]
                cell.configureCell(image: image)
                
                return cell
            }
            return UICollectionViewCell()
        }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: CollectionViewCell = Bundle.main.loadNibNamed(CollectionViewCell.nibName,
                                                                      owner: self,
                                                                      options: nil)?.first as? CollectionViewCell else {
            return CGSize.zero
        }
        cell.configureCell(image: images[indexPath.row])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 354)
    }
}


