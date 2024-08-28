//
//  UserInfoTableCell.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 26.08.2024.
//

import UIKit
import SnapKit

class UserInfoTableCell: UITableViewCell {
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var subscriptionStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private var userModel: UserModel?
    
    static let id: String = "UserInfoTableCellID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(6)
            make.height.equalTo(22)
        }
        
        addSubview(subscriptionStatusLabel)
        subscriptionStatusLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(emailLabel.snp.bottom)
            make.height.equalTo(22)
            make.bottom.equalToSuperview().offset(-6)
        }
    }
    
    func configure(_ model: UserModel) {
        userModel = model
        
        guard let userModel else { return }
        emailLabel.text = userModel.email
        subscriptionStatusLabel.text = "Пробная подписка до 2 декабря"
    }
}
