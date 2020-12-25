//
//  CollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 06.12.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
  //MARK: Outlets
 
  
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!{

        didSet {
            myImage.layer.cornerRadius = 10
        }
    }

    
    
    //MARK: Initializer
    func configureCell(image: Data, title: String, writer: String, genre: String) {
        self.myImage.image = UIImage(data: image)
        self.nameLabel.text = title
        self.genreLabel.text = genre
        self.writerLabel.text = writer
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
