//
//  UserTableCell.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 07.08.2024.
//

import UIKit

public class UserTableCell: UITableViewCell {
    
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .secondaryLabel.withAlphaComponent(0.5)
        view.clipsToBounds = true
        view.image = userImage
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        return label
    }()
    
    private let title: String
    private let userImage: UIImage?
    
    public init(title: String, userImage: UIImage?) {
        self.title = title
        self.userImage = userImage
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
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(userImageView.snp.trailing).offset(14)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}

