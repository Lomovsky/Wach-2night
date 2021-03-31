//
//  GenreViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 29.03.2021.
//

import UIKit

final class GenreViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .init(x: 0, y: 178, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GenreViewConrtollerCollectionViewCell.self,
                    forCellWithReuseIdentifier: GenreViewConrtollerCollectionViewCell.reuseIdentifier)
        return cv
    }()
    
    let viewModel: GenreViewViewModelType = GenreViewViewModel()
    let collectionViewModel: GenreViewCollectionViewViewModelType = GenreViewCollectionViewViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        viewModel.downloadFilms(condition: .download)
        setupView()
        setupCollectionView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        collectionView.backgroundColor = .clear
        
    }
}



//MARK: Extensions -
extension GenreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreViewConrtollerCollectionViewCell.reuseIdentifier, for: indexPath) as? GenreViewConrtollerCollectionViewCell {
            let viewModel = collectionViewModel.cellViewModel(forIndexPath: indexPath)
            cell.viewModel = viewModel
//            cell.backgroundColor = .red
//            cell.layer.cornerRadius = 10
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.size.width * 0.3, height: view.frame.size.height * 0.2)
    }
    
}
