//
//  TableViewCell.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 03.02.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    class var cellID: String {
        return "Cell"
    }
    
    //MARK: Declarations
    var activityIndicator: UIActivityIndicatorView = {
        let acrivityIndicator = UIActivityIndicatorView()
        acrivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return acrivityIndicator
    }()
    
    
    weak var viewModel: SearchViewTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.textLabel?.text = viewModel.title
        }
    }
    
    //MARK: Initializer -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: TableViewCell.cellID)
        imageView?.image = #imageLiteral(resourceName: "1024px-No_image_available.svg")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActivityIndicator() {
        activityIndicator.topAnchor.constraint(equalTo: imageView?.topAnchor ?? contentView.topAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: imageView?.leadingAnchor ?? contentView.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: imageView?.trailingAnchor ?? textLabel!.leadingAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: imageView?.bottomAnchor ?? contentView.bottomAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
}

