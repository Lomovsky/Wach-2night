//
//  PreviewVC+UIFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.02.2021.
//

import UIKit

extension PreviewViewController {
    //MARK: UIFuncs -

    final func setupView() {
        view.backgroundColor = .white
    }
      
    final func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(contentView)
    }
    
//    final func setupStackView() {
//        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
//        stackView.addArrangedSubview(imageView)
//        stackView.addArrangedSubview(titleLabel)
//        stackView.addArrangedSubview(overviewLabel)
//        stackView.addArrangedSubview(overviewText)
//        stackView.addArrangedSubview(favoriteButton)
//    }
//
    func setupContentView() {
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor).isActive = true
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: 250)
        heightConstraint.isActive = true
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewText)
        contentView.addSubview(favoriteButton)

    }

    
    final func setupImageView() {
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.frame.size.height = view.frame.height * 0.6
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let resizedPoster = viewModel?.poster.resizeImageUsingVImage(size: .init(width: view.frame.width, height: view.frame.height * 0.6))
        imageView.image = resizedPoster
        
    }
    
    final func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        titleLabel.font = .systemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        titleLabel.frame.size.height = 49
        titleLabel.text = viewModel?.title
    }
    
    final func setupOverviewLabel() {
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5).isActive = true
        overviewLabel.text = "Сюжет"
        overviewLabel.font = .boldSystemFont(ofSize: 12)
        overviewLabel.textColor = .black
    }

    final func setupOverviewText() {
        overviewText.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 3).isActive = true
        overviewText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        overviewText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        overviewText.numberOfLines = 0
        overviewText.font = .systemFont(ofSize: 16, weight: .light)
        overviewText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
        overviewText.text = viewModel?.overview
        }
    
    final func setupFavoriteButton() {
        favoriteButton.topAnchor.constraint(equalTo: overviewText.bottomAnchor, constant: 10).isActive = true
        favoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        favoriteButton.backgroundColor = .systemGreen
        favoriteButton.titleLabel?.textColor = .white
        favoriteButton.layer.cornerRadius = 10
      
    }
    
}
