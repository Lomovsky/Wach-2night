//
//  CollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 06.12.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
  //MARK: Outlets
    @IBOutlet weak var filmImage: UIImageView! {
        
        didSet {
            let cornerRadius: CGFloat = 10.0
            filmImage.layer.cornerRadius = 10
            filmImage.layer.cornerRadius = cornerRadius
            filmImage.layer.shadowColor = UIColor.black.cgColor
            filmImage.layer.shadowRadius = 7
            filmImage.layer.shadowOpacity = 0.7
            filmImage.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
            
            let cgPath = UIBezierPath(roundedRect: filmImage.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius)).cgPath
            filmImage.layer.shadowPath = cgPath
            
        }
    }
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateTitle: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!


    
    //MARK: Initializer
    func configureCell(image: Data, title: String, originalTitle: String, releaseDate: String, rating: Float) {
        self.filmImage.image = UIImage(data: image)
        self.titleLabel.text = title
        self.originalTitle.text = originalTitle
        self.releaseDateTitle.text = releaseDate
        self.ratingLabel.text = String(rating)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    class var reuseIdentifier: String {
        return "CollectionViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "CollectionViewCell"
    }
    

}
