//
//  CollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 06.12.2020.
//

import UIKit

class RecommendationsCollectionViewCell: UICollectionViewCell {
    
    class var reuseIdentifier: String {
        return "CollectionViewCellReuseIdentifier"
    }
    

    // MARK: Declarations
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    weak var viewModel: SuggestionCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.imageView.image = viewModel.poster
        }
    }
    
    

    
    //MARK: Initializer -
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        
        
        
        setupImageView()
   
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup funcs -
    
    private func setupImageView() {
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
  


    // MARK: Configuring the cell -
    final func configureCell(image: UIImage, title: String, originalTitle: String, releaseDate: String, rating: Float) {
        self.imageView.image = image

    }
    
}


