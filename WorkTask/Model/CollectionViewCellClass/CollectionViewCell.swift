//
//  CollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 06.12.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: Declarations
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        let cornerRadius: CGFloat = 10.0
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowRadius = 7
        stack.layer.shadowOpacity = 0.7
        stack.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
        
        let cgPath = UIBezierPath(roundedRect: stack.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius)).cgPath
        stack.layer.shadowPath = cgPath
        stack.backgroundColor = .yellow
        return stack
    }()
    

    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        setupStackView()
        setupImageView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        stackView.addSubview(imageView)

        
        stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: -30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: -10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true

        
    }
    
    private func setupImageView() {

        imageView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true

    }
    
    
    
    func configureCell(image: Data, title: String, originalTitle: String, releaseDate: String, rating: Float) {
        self.imageView.image = UIImage(data: image)
//        self.titleLabel.text = title
//        self.originalTitle.text = originalTitle
//        self.releaseDateTitle.text = releaseDate
//        self.ratingLabel.text = String(rating)
    }

    override class func awakeFromNib() {
        
    }
    
    class var reuseIdentifier: String {
        return "CollectionViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "CollectionViewCell"
    }
    


}

///        let cornerRadius: CGFloat = 10.0
//           imageStackView.layer.shadowColor = UIColor.black.cgColor
//           imageStackView.layer.shadowRadius = 7
//           imageStackView.layer.shadowOpacity = 0.7
//           imageStackView.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
//
//           let cgPath = UIBezierPath(roundedRect: imageStackView.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius)).cgPath
//           imageStackView.layer.shadowPath = cgPath
//
