//
//  CollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 06.12.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
  //MARK: Outlets
    @IBOutlet weak var filmImage: UIImageView!{
        
        didSet {
            filmImage.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
  


    
    //MARK: Initializer
    func configureCell(image: Data, title: String, originalTitle: String) {
        self.filmImage.image = UIImage(data: image)
        self.titleLabel.text = title
        self.originalTitle.text = originalTitle
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
