//
//  MoreViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 12.02.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: Declarations
    let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    let backButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    let mainScreenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK:viewDidLoad & viewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundView)
        view.addSubview(mainView)
        view.addSubview(backButtonView)
        view.addSubview(mainScreenLabel)
        view.addSubview(refreshButton)
        view.addSubview(backButton)
        
    
        setupView()
        setupBackgroundView()
        setupMainView()
        setupMainScreenLabel()
        setupRefreshButton()
        setupBackButtonView()
        setupBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        setupNavigationController()
    }
    

    //MARK: UIFuncs
    private func setupView() {
        view.backgroundColor = .clear
//        let effect = UIBlurEffect(style: UIBlurEffect.Style.light)
//        let blurView = UIVisualEffectView(effect: effect)
//        blurView.frame = self.view.bounds

//        self.view.addSubview(blurView)
    }
    
    private func setupBackgroundView() {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = self.view.bounds
        blurView.layer.cornerRadius = 10
        backgroundView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 70).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.backgroundColor = UIColor(cgColor: CGColor.init(red: 0.50, green: 0.50, blue: 0.50, alpha: 0.5))
        backgroundView.layer.cornerRadius = 10
//        backgroundView.addSubview(blurView)
        backgroundView.addSubview(mainView)
        backgroundView.addSubview(mainScreenLabel)
        backgroundView.addSubview(backButtonView)
        
    }
    
    private func setupMainView() {
        mainView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5).isActive = true
        mainView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -5).isActive = true
        mainView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.8).isActive = true
        mainView.backgroundColor = .white
        mainView.addSubview(mainScreenLabel)
        mainView.addSubview(refreshButton)
    }
    
    
    private func setupMainScreenLabel() {
        mainScreenLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        mainScreenLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        mainScreenLabel.text = "Настройки главного экрана"
        mainScreenLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func setupRefreshButton() {
        refreshButton.topAnchor.constraint(equalTo: mainScreenLabel.bottomAnchor, constant: 15).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5).isActive = true
        refreshButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5).isActive = true
        refreshButton.backgroundColor = .systemGreen
        refreshButton.layer.cornerRadius = 10
        refreshButton.setTitle("Обновить рекомендации", for: .normal)
        refreshButton.addTarget(self, action: #selector(updateRecommendations), for: .touchUpInside)
        
    }
    
    private func setupBackButtonView() {
        backButtonView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 10).isActive = true
        backButtonView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5).isActive = true
        backButtonView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -5).isActive = true
        backButtonView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20).isActive = true
        backButtonView.backgroundColor = .systemGray4
        backButtonView.addSubview(backButton)
    }
    
    private func setupBackButton() {
        backButton.topAnchor.constraint(equalTo: backButtonView.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: backButtonView.leadingAnchor, constant: 10).isActive = true
        backButton.trailingAnchor.constraint(equalTo: backButtonView.trailingAnchor, constant: -10).isActive = true
        backButton.bottomAnchor.constraint(equalTo: backButtonView.bottomAnchor, constant: -10).isActive = true
        backButton.backgroundColor = .systemGray4
        backButton.layer.cornerRadius = 10
        backButton.setTitle("Отмена", for: .normal)
        backButton.setTitleColor(.red, for: .normal)
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
    }

}

extension SettingsViewController {
    
    @objc func updateRecommendations() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh recommendations"), object: nil)
        
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
}
