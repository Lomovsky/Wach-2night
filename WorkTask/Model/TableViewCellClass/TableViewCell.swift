//
//  TableViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 03.02.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //MARK: Declarations
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let ratingStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    weak var viewModel: SearchViewTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.textLabel?.text = viewModel.title
            self.imageView?.image = viewModel.poster
        }
    }
    
    //MARK: Initializer -
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
        imageView?.clipsToBounds = true
        imageView?.layer.cornerRadius = 20
        
    }
    
    
    
    //MARK: SetupFuncs -

    private func setupRatingStackView() {
        ratingStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        ratingStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        ratingStackView.frame.size.width = 30
        ratingStackView.addSubview(starImage)
        
    }
    
    private func setupStarImage() {
        starImage.leadingAnchor.constraint(equalTo: ratingStackView.leadingAnchor).isActive = true
        starImage.centerYAnchor.constraint(equalTo: ratingStackView.centerYAnchor).isActive = true
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = .systemYellow
    }
}
