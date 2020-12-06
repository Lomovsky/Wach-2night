//
//  CollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 06.12.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var myImage: UIImageView!{
        didSet{
        
            myImage.clipsToBounds = true
        }
    }
    
    func configureCell(image: String) {
        self.myImage.image = UIImage(named: image)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    func configureCell(image: String) {
//        self.myImage.image = UIImage.init(named: image)
//    }
    
    class var reuseIdentifier: String {
        return "CollectionViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "CollectionViewCell"
    }
    

}
