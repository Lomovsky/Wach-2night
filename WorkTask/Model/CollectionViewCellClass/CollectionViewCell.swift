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
            let cornerRad: CGFloat = 10.0
            filmImage.layer.cornerRadius = cornerRad
            
        }
    }
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel! {
        
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
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
