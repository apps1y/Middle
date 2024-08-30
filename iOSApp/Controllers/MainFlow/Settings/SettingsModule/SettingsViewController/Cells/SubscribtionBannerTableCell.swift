//
//  SubscribtionBannerTableCell.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 28.08.2024.
//

import UIKit
import SnapKit

struct SubscribtionBannerCellModel: Hashable {
    var title: String = "Оформить подписку"
    var description: String = "Получите доступ ко всем функциям приложения!"
    var backgroundColor: UIColor = .systemIndigo
}


class SubscribtionBannerTableCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.backgroundColor = .white
        label.layer.cornerRadius = 11
        label.textAlignment = .center
        label.text = "Перейти"
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var backgroundGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0).cgColor,
            UIColor(red: 0/255.0, green: 3/255.0, blue: 70/255.0, alpha: 1.0).cgColor,
            UIColor(red: 55/255.0, green: 75/255.0, blue: 196/255.0, alpha: 1.0).cgColor,
            UIColor(red: 186/255.0, green: 162/255.0, blue: 239/255.0, alpha: 1.0).cgColor,
            UIColor(red: 0/255.0, green: 73/255.0, blue: 153/255.0, alpha: 1.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }()
    
    static let id: String = "SubscribtionBannerTableCellID"
    
    private var subscriptionModel: SubscribtionBannerCellModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundGradient.frame = bounds
    }
    
    private func setupUI() {
        selectionStyle = .none
        layer.addSublayer(backgroundGradient)
        
        addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.trailing.top.equalToSuperview().inset(10)
            make.height.equalTo(22)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
            make.trailing.equalTo(buttonLabel.snp.leading).offset(-10)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(buttonLabel.snp.leading).offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func configure(_ model: SubscribtionBannerCellModel) {
        subscriptionModel = model
        
        guard let subscriptionModel else { return }
        titleLabel.text = subscriptionModel.title
        descriptionLabel.text = subscriptionModel.description
    }
}
