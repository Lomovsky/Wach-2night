//
//  CollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 06.12.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
  //MARK: Outlets
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!{
        didSet {
            myImage.layer.cornerRadius = 10
        }
    }

    
    
    //MARK: Initializer
    func configureCell(image: String, label: String) {
        self.myImage.image = UIImage(named: image)
        self.myLabel.text = label
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
