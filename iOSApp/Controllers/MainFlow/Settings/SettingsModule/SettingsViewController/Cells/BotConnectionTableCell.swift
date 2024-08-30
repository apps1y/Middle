//
//  BotConnectionTableCell.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 29.08.2024.
//

import UIKit
import SnapKit

struct BotConnectionCellModel: Hashable {
    var isConnectedBot: Bool
}

class BotConnectionTableCell: UITableViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var cellTextLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    static let id: String = "BotConnectionTableCellID"
    
    private var cellModel: BotConnectionCellModel = BotConnectionCellModel(isConnectedBot: false)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        addSubview(cellTextLabel)
        cellTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func configure(_ model: BotConnectionCellModel) {
        self.cellModel = model
        
        if cellModel.isConnectedBot {
            iconImageView.image = UIImage(systemName: "checkerboard.shield")
            cellTextLabel.text = "Бот подкючен"
        } else {
            iconImageView.image = UIImage(systemName: "link.badge.plus")
            cellTextLabel.text = "Подключить бота"
        }
    }
}
