//
//  FavouriteFilmsCollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 07.02.2021.
//

import UIKit

class FavouriteFilmsCollectionViewCell: UICollectionViewCell {
    
    //MARK: Declarations
    
    class var reuseIdentifier: String {
        return "FavouriteFilms cell indentifier"
    }
    
    let imagePlaceholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    weak var viewModel: FavoritesCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.imageView.image = viewModel.poster
        }
    }
    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        contentView.addSubview(imagePlaceholder)
        
        setupImageView()
        setupImagePlaceholder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup funcs
    
    private func setupImagePlaceholder() {
        imagePlaceholder.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imagePlaceholder.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imagePlaceholder.font = .systemFont(ofSize: 16, weight: .light)
        imagePlaceholder.textColor = .systemGray
        imagePlaceholder.isHidden = true
    }
    
    private func setupImageView() {
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
 
}
