//
//  UILeafScrollViewCell.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 18.08.2024.
//

import UIKit
import SnapKit

class UILeafScrollViewCell: UICollectionViewCell {
    
    private lazy var dateLabel = UILabel()
    
    static let id = "UILeafScrollViewCellID"
    
    private var dayModel: DayModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(model: DayModel) {
        dayModel = model
        dateLabel.text = "\(model.date.dateFormatddMMyyyy()), кол-во: \(model.messages.count)"
    }
}

