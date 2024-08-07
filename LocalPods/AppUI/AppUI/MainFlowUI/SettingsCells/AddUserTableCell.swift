//
//  AddTableCell.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 07.08.2024.
//

import UIKit
import SnapKit

public class AddUserTableCell: UITableViewCell {
        
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: systemImage)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.textColor = .systemBlue
        return label
    }()
    
    private let title: String
    private let systemImage: String
    
    public init(title: String, systemImage: String) {
        self.title = title
        self.systemImage = systemImage
        super.init(style: .default, reuseIdentifier: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
            make.size.equalTo(28)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconView.snp.trailing).offset(14)
            make.trailing.equalToSuperview().inset(14)
        }
    }
}


