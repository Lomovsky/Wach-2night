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
        view.backgroundColor = .systemGray6
    }
      
    func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(stackView)
    }
    
    func setupStackView() {
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(overviewLabel)
        stackView.addArrangedSubview(overviewBackground)
        stackView.addArrangedSubview(favoriteButton)
    }
    
    func setupImageView() {
        imageView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        imageView.frame.size.height = view.frame.height * 0.6
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
    }
    
    func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.numberOfLines = 0
        titleLabel.frame.size.height = 49
    }
    
    func setupOverviewLabel() {
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5).isActive = true
        overviewLabel.text = "Сюжет:"
        overviewLabel.font = .systemFont(ofSize: 20, weight: .medium)
        overviewLabel.textColor = .systemGray
    }
    
    func setupOverviewBackground() {
        overviewBackground.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10).isActive = true
        overviewBackground.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        overviewBackground.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        overviewBackground.bottomAnchor.constraint(equalTo: overviewText.bottomAnchor, constant: 5).isActive = true
        overviewBackground.backgroundColor = .white
        overviewBackground.layer.cornerRadius = 10
        overviewBackground.addSubview(overviewText)
    }


    
    func setupOverviewText() {
        overviewText.topAnchor.constraint(equalTo: overviewBackground.topAnchor, constant: 5).isActive = true
        overviewText.leadingAnchor.constraint(equalTo: overviewBackground.leadingAnchor, constant: 5).isActive = true
        overviewText.trailingAnchor.constraint(equalTo: overviewBackground.trailingAnchor, constant: -5).isActive = true
        overviewText.numberOfLines = 0
        overviewText.font = .systemFont(ofSize: 17, weight: .light)
        }
    
    func setupFavoriteButton() {
        favoriteButton.topAnchor.constraint(equalTo: overviewBackground.bottomAnchor, constant: 5).isActive = true
        favoriteButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        favoriteButton.backgroundColor = .systemGreen
        favoriteButton.titleLabel?.textColor = .white
        favoriteButton.layer.cornerRadius = 10
      
    }
    
}
