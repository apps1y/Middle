//
//  SettingsTableCell.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 06.08.2024.
//

import UIKit

public class SettingsTableCell: UITableViewCell {
    
    private lazy var iconBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.cornerCurve = .continuous
        view.backgroundColor = iconBackgroundColor
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        let symbolConfiguration = UIImage.SymbolConfiguration(weight: symbolWeight)
        view.image = UIImage(systemName: systemImage, withConfiguration: symbolConfiguration)
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        return label
    }()
    
    private let title: String
    private let systemImage: String
    private let iconBackgroundColor: UIColor
    private let iconTint: UIColor
    private let symbolWeight: UIImage.SymbolWeight
    
    public init(title: String, systemImage: String, iconBackgroundColor: UIColor, iconTint: UIColor = .white, symbolWeight: UIImage.SymbolWeight = .bold) {
        self.title = title
        self.systemImage = systemImage
        self.iconBackgroundColor = iconBackgroundColor
        self.iconTint = iconTint
        self.symbolWeight = symbolWeight
        super.init(style: .default, reuseIdentifier: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(iconBackgroundView)
        iconBackgroundView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
            make.size.equalTo(28)
        }
        
        iconBackgroundView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(20)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(14)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
