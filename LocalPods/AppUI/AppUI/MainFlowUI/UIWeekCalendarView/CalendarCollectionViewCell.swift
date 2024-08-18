//
//  CalendarCollectionViewCell.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 17.08.2024.
//

import UIKit
import SnapKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    private lazy var numberOfDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "17"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    static let id = "CalendarCollectionViewCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backgroundCell)
        backgroundCell.snp.makeConstraints { make in
            make.margins.equalToSuperview().inset(8)
        }
        
        backgroundCell.addSubview(numberOfDayLabel)
        numberOfDayLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func configure(_ model: WeekCalendarDateModel, isTapped: Bool) {
        numberOfDayLabel.text = model.numberOfDay
        self.backgroundCell.backgroundColor = isTapped ? .systemBlue : .clear
        self.numberOfDayLabel.textColor = isTapped ? .white : .label
    }
}


