//
//  TableViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 03.02.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
//MARK: Declarations
    let poster: UIImageView = {
        let poster = UIImageView()
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(poster)
        
        setupImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    private func setupImageView() {
        imageView?.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3).isActive = true
        imageView?.clipsToBounds = true
        imageView?.layer.cornerRadius = 20
    }
}
