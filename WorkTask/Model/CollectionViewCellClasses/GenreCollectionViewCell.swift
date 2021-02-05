//
//  GenreCollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.02.2021.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    class var reuseIdentifier: String {
        return "GenreCellReuseIdentifier"
    }
    
    //MARK: Declarations
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(genreLabel)
        
        setupGenreLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: SettupFuncs
    private func setupGenreLabel () {
        genreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        genreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        genreLabel.textColor = #colorLiteral(red: 0.9769931436, green: 0.51498878, blue: 0.4180260897, alpha: 1)
        genreLabel.font = .systemFont(ofSize: 20)
    }
    
    func configureTheCell(genreLabel: String) {
        self.genreLabel.text = genreLabel
    }
}
