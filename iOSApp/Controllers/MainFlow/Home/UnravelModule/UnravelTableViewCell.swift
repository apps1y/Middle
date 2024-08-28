//
//  UnravelTableViewCell.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 21.08.2024.
//

import UIKit
import SnapKit

protocol IUnravelCellView: UIView {
    func configure(viewModel: MessagePreviewModel)
}

class UnravelCellView: UIView, IUnravelCellView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 17
        view.layer.cornerCurve = .circular
        return view
    }()
    
    private lazy var unravelLabel: UILabel = {
        let label = UILabel()
        label.text = "unravelLabel"
        label.textColor = .label
        return label
    }()
    
    private lazy var messageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        view.layer.cornerCurve = .circular
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.text = "ownerLabel"
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "messageLabel"
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var verticalDividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private var unravelModel: MessagePreviewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: MessagePreviewModel) {
        unravelModel = viewModel
        
        ownerLabel.text = viewModel.ownerName
        messageLabel.text = viewModel.text
        unravelLabel.text = viewModel.unravel?.description
    }
    
    private func setupUI() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(17)
            make.verticalEdges.equalToSuperview().inset(5)
        }
        
        backgroundView.addSubview(unravelLabel)
        unravelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalToSuperview().offset(9)
        }
        
        backgroundView.addSubview(messageBackgroundView)
        messageBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(unravelLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        messageBackgroundView.addSubview(verticalDividerLine)
        verticalDividerLine.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
            make.width.equalTo(5)
        }
        
        messageBackgroundView.addSubview(ownerLabel)
        ownerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(verticalDividerLine.snp.trailing).offset(7)
        }
        
        messageBackgroundView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(ownerLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(verticalDividerLine.snp.trailing).offset(7)
        }
    }
}

class UnravelTableViewCell: UITableViewCell {
    private lazy var view = UnravelCellView()
    
    static let id = "UnravelTableViewCellID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: MessagePreviewModel) {
        view.configure(viewModel: viewModel)
    }
}
