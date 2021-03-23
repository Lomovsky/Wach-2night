//
//  GenreCollectionViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 05.02.2021.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    //MARK: Declarations
    class var reuseIdentifier: String {
        return "GenreCellReuseIdentifier"
    }
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    weak var viewModel: GenreCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.genreLabel.text = viewModel.title
        }
    }
    
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
        genreLabel.textColor = .systemGreen
        genreLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
}
