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
//    func setGradientBackground() {
//        let colorTop =  UIColor.clear.cgColor
//        let colorBottom = UIColor.white.cgColor
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = [colorTop, colorBottom]
//            gradientLayer.locations = [0.0, 1.0]
//            gradientLayer.frame = self.contentView.bounds
//            self.contentView.layer.insertSublayer(gradientLayer, at: 0)
//        }
//    
//    func setupGradient() {
//        let gradient: CAGradientLayer = CAGradientLayer()
//         gradient.frame = self.imageSubviewShadow.bounds
//        gradient.colors = [  UIColor.white.cgColor, UIColor.clear.cgColor  ]
//         gradient.locations = [0.0, 0.75]
//         gradient.cornerRadius = 5
//        self.imageSubviewShadow.layer.insertSublayer(gradient, at: 0)
//    }
    
    private func setupImageView() {
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
  

    
    // MARK: Configuring the cell -
    func configureCell(image: UIImage, title: String, originalTitle: String, releaseDate: String, rating: Float) {
        self.imageView.image = image

    }
    
}


