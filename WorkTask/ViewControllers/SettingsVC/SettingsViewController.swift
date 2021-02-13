//
//  MoreViewController.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 12.02.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: Declarations
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
    
    
    //MARK:viewDidLoad & viewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainScreenLabel)
        view.addSubview(refreshButton)
        
        setupView()
        setupMainScreenLabel()
        setupRefreshButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }
    

    //MARK: UIFuncs
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.visibleViewController?.title = "Настройки"
    }
    
    private func setupMainScreenLabel() {
        mainScreenLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        mainScreenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        mainScreenLabel.text = "Настройки главного экрана"
        mainScreenLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func setupRefreshButton() {
        refreshButton.topAnchor.constraint(equalTo: mainScreenLabel.bottomAnchor, constant: 15).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        refreshButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        refreshButton.backgroundColor = .systemGreen
        refreshButton.layer.cornerRadius = 10
        refreshButton.setTitle("Обновить рекомендации", for: .normal)
        refreshButton.addTarget(self, action: #selector(updateRecommendations), for: .touchUpInside)
        
    }

}

extension SettingsViewController {
    
    @objc func updateRecommendations() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh recommendations"), object: nil)
        
    }
}
