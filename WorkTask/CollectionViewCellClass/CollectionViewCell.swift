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
    @IBOutlet var secondStackView: UIStackView!

    @IBOutlet var stackView: UIStackView!{
        didSet {
            stackView.layer.cornerRadius = 20
            
            
        }
    }
    @IBOutlet var imdbLabel: UILabel!{
        didSet {
            imdbLabel.layer.cornerRadius = 10
        }
    }
    @IBOutlet var numbersLabel: UILabel!{
        didSet {
            numbersLabel.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var myImage: UIImageView!{

        didSet {
            myImage.layer.cornerRadius = 10
        }
    }

    
    
    //MARK: Initializer
    func configureCell(image: String) {
        self.myImage.image = UIImage(named: image)
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
