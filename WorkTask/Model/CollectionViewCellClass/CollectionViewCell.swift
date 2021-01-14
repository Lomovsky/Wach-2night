//
//  CollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 06.12.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    class var reuseIdentifier: String {
        return "CollectionViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "CollectionViewCell"
    }
    
    
// MARK: Declarations
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imdbLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    

    
//MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        contentView.addSubview(originalTitleLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingStack)
        contentView.addSubview(imdbLabel)
        
        
        setupImageView()
        setupOriginalTitleLabel()
        setupTitleLabel()
        setupRatingLabel()
        setupIMDBLabel()
        setupYearLabel()
        setupRatingStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Setup funcs -

    private func setupImageView() {
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

    }
    
    private func setupOriginalTitleLabel() {
        originalTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        originalTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        originalTitleLabel.font = .systemFont(ofSize: 12)
        originalTitleLabel.textColor = .systemGray
        
    }
    
    private func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.frame.size.height = 49
        titleLabel.numberOfLines = 3
        

    }
    
    private func setupRatingStack() {
        ratingStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        ratingStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        ratingStack.frame.size.width = 70
        ratingStack.layer.cornerRadius = 10
        ratingStack.addSubview(imdbLabel)
    }
    
    private func setupRatingLabel() {
 
 
        
    }
    
    private func setupIMDBLabel() {
        imdbLabel.leadingAnchor.constraint(equalTo: ratingStack.leadingAnchor, constant: 3).isActive = true
        imdbLabel.centerYAnchor.constraint(equalTo: ratingStack.centerYAnchor).isActive = true
        imdbLabel.text = "11"
        imdbLabel.textColor = .white
    }
    
    private func setupYearLabel() {
        
    }
    
    
    func configureCell(image: UIImage, title: String, originalTitle: String, releaseDate: String, rating: Float) {
        self.imageView.image = image
        self.originalTitleLabel.text = originalTitle
        self.titleLabel.text = title
//        self.releaseDateTitle.text = releaseDate
//        self.ratingLabel.text = String(rating)
    }


    


}


///imageView.layer.cornerRadius = 10
///imageView.layer.shadowColor = UIColor.black.cgColor
///imageView.layer.shadowRadius = 7
///imageView.layer.shadowOpacity = 0.7
///imageView.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
///let cgPath = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius)).cgPath
///imageView.layer.shadowPath = cgPath
