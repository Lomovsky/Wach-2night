//
//  SecondViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 17.12.2020.
//

import UIKit

class PreviewViewController: UIViewController {
    
    //MARK: Declarations
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    let yearPlaceHolderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overviewText: UILabel = {
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.sizeToFit()
        return tf
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: viewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(infoButton)
        view.addSubview(titleLabel)
        view.addSubview(yearLabel)
        view.addSubview(yearPlaceHolderLabel)
        view.addSubview(containerView)
        view.addSubview(scrollView)
        view.addSubview(overviewText)
        
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        setupImageView()
        setupNavigationController()
        setupViewController()
        setupInfoButton()
        setupYearLabel()
        setupTitleLabel()
        setupYearPlaceholderLabel()
        setupContainerView()
        setupScrollView()
        setupOverviewLabel()
        setupContentView()
    }
    
    
    //MARK: Setup Funcs
    @objc func buttonPressed() {
        dismiss(animated: true)
    }
    
    private func setupViewController() {
        view.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)
    }
    
    private func setupNavigationController() {
        
    }
    
    private func setupScrollView() {
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 200).isActive = true
        scrollView.addSubview(contentView)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupContentView() {
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollView.addSubview(containerView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(infoButton)
        scrollView.addSubview(overviewText)
    }
    
    private func setupContainerView() {
        let cornerRadius: CGFloat = 10.0
        let cgPath = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius)).cgPath
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        containerView.addSubview(imageView)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 7
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
        containerView.layer.shadowPath = cgPath
        
    }
    
    private func setupImageView() {
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        imageView.frame.size.height = imageView.image!.accessibilityFrame.height
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
    }
    
    private func setupInfoButton() {
        infoButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        infoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        infoButton.frame.size.height = 30
        infoButton.backgroundColor = .systemBlue
        infoButton.layer.cornerRadius = 10
        infoButton.setTitle("Детальная информация", for: .normal)
        infoButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func setupYearLabel() {
        yearLabel.topAnchor.constraint(equalTo: yearPlaceHolderLabel.bottomAnchor, constant: 5).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
        yearLabel.font = .systemFont(ofSize: 15)
        yearLabel.textColor = .systemGray
    }
    
    private func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        titleLabel.font = .boldSystemFont(ofSize: 30)
    }
    
    private func setupYearPlaceholderLabel() {
        yearPlaceHolderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        yearPlaceHolderLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
        yearPlaceHolderLabel.font = .systemFont(ofSize: 18)
        yearPlaceHolderLabel.textColor = .black
        yearPlaceHolderLabel.text = "Дата релиза:"
    }
    
    private func setupOverviewLabel() {
        overviewText.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 10).isActive = true
        overviewText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        overviewText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5).isActive = true
        overviewText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        overviewText.numberOfLines = 0
        
        
    }
    
    
    deinit {
        print("Sec vc was dealocated")
    }
    
}
