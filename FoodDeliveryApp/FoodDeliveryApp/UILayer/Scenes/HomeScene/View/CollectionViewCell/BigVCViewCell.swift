//
//  BigVCViewCell.swift
//  FoodDeliveryApp
//
//  Created by Vova Lincore on 07.05.2024.
//

import UIKit

class BigVCViewCell: UICollectionViewCell {
    let topView = UIView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        contentView.backgroundColor = .blue
        setupTopView()
        setupBottomLabel()
    }
    
    func setupTopView() {
        contentView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .green
        topView.layer.cornerRadius = 20
        topView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            topView.widthAnchor.constraint(equalToConstant: 130),
            topView.heightAnchor.constraint(equalToConstant: 130),
        ])
    }
    
    func setupBottomLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.font = .Roboto.regular.size(of: 14)
        titleLabel.text = "Title label"
        titleLabel.textColor = .black
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 15),
        ])
    }
}
