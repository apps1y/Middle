//
//  UserTableCell.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 07.08.2024.
//

import UIKit

public class UserTableCell: UITableViewCell {
    
    private lazy var userImageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        view.layer.insertSublayer(userImageGradientLayer, at: 0)
        return view
    }()
    
    private lazy var letterImageLabel: UILabel = {
        let label = UILabel()
        label.text = String(title.first ?? " ")
        label.textColor = .white
        if let fontDescriptor: UIFontDescriptor = UIFont.systemFont(ofSize: 16, weight: .bold).fontDescriptor.withDesign(.rounded) {
            label.font = UIFont(descriptor: fontDescriptor, size: 16)
        }
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        return label
    }()
    
    private lazy var userImageGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor(red: 135/255, green: 206/255, blue: 247/255, alpha: 1).cgColor,
            UIColor(red: 81/255, green: 156/255, blue: 233/255, alpha: 1).cgColor
        ]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return layer
    }()
    
    private let title: String
    
    public init(title: String) {
        self.title = title
        super.init(style: .default, reuseIdentifier: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
            make.size.equalTo(30)
        }
        
        userImageView.addSubview(letterImageLabel)
        letterImageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(userImageView.snp.trailing).offset(14)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}

