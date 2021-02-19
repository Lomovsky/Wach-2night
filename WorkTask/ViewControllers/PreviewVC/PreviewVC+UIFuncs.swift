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
        stackView.addArrangedSubview(overviewText)
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
        titleLabel.font = .systemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        titleLabel.frame.size.height = 49
    }
    
    func setupOverviewLabel() {
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5).isActive = true
        overviewLabel.text = "Сюжет"
        overviewLabel.font = .boldSystemFont(ofSize: 12)
        overviewLabel.textColor = .black
    }

    func setupOverviewText() {
        overviewText.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 3).isActive = true
        overviewText.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        overviewText.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        overviewText.numberOfLines = 0
        overviewText.font = .systemFont(ofSize: 16, weight: .light)
        overviewText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
        }
    
    func setupFavoriteButton() {
        favoriteButton.topAnchor.constraint(equalTo: overviewText.bottomAnchor, constant: 10).isActive = true
        favoriteButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        favoriteButton.backgroundColor = .systemGreen
        favoriteButton.titleLabel?.textColor = .white
        favoriteButton.layer.cornerRadius = 10
      
    }
    
}
