//
//  PreviewVC+UIFuncs.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.02.2021.
//

import UIKit

extension PreviewViewController {
    //MARK: UIFuncs -

    func setupView() {
        view.backgroundColor = .white
    }
      
    func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.addSubview(stackView)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func setupStackView() {
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(favoriteButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(overviewText)
    }
    
    func setupImageView() {
        imageView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        imageView.frame.size.height = imageView.image!.accessibilityFrame.height
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
    }
    
    func setupFavoriteButton() {
        favoriteButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        favoriteButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        favoriteButton.backgroundColor = .systemGreen
        favoriteButton.titleLabel?.textColor = .white
        favoriteButton.layer.cornerRadius = 10
      
    }
    
    func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.numberOfLines = 0
        titleLabel.frame.size.height = 49
    }
    
    func setupOverviewLabel() {
        overviewText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        overviewText.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        overviewText.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5).isActive = true
        overviewText.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        overviewText.numberOfLines = 0
        }
    
}
