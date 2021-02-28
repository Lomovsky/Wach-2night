//
//  GenreCollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.02.2021.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    class var reuseIdentifier: String {
        return "GenreCellReuseIdentifier"
    }
    
    //MARK: Declarations
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(genreLabel)
        
        setupGenreLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: SettupFuncs
    private func setupGenreLabel () {
        genreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        genreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        genreLabel.textColor = .systemGreen
        genreLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    
    func setGradientBackground() {
        let colorTop =  UIColor.systemGreen.cgColor
        let colorBottom = UIColor.systemTeal.cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.contentView.bounds
            self.contentView.layer.insertSublayer(gradientLayer, at: 0)
        }
    
 
}
