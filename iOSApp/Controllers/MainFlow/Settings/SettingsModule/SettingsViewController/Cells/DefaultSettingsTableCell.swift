//
//  DefaultSettingsTableCell.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 28.08.2024.
//

import UIKit
import SnapKit

struct DefaultSettingsCellModel: Hashable {
    let image: UIImage?
    let text: String
}

class DefaultSettingsTableCell: UITableViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var cellTextLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    static let id: String = "DefaultSettingsTableCellID"
    
    private var cellModel: DefaultSettingsCellModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        accessoryType = .disclosureIndicator
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(28)
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
    
    func configure(_ model: DefaultSettingsCellModel) {
        self.cellModel = model
        
        guard let cellModel else { return }
        iconImageView.image = cellModel.image
        cellTextLabel.text = cellModel.text
    }
}
