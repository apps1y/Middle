//
//  MessageTableViewCell.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 19.08.2024.
//

import UIKit
import SnapKit

protocol IMessagePreviewView: UIView {
    func configure(viewModel: MessagePreviewModel)
}

class MessagePreviewView: UIView, IMessagePreviewView {
    
    private lazy var statusLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private lazy var statusBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var statusCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 6
        view.isHidden = true
        return view
    }()
    
    private lazy var statusWarningButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "exclamationmark.triangle.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(warningButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.text = " "
        return label
    }()
    
    lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.85)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 11)
        label.text = " "
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.85)
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.text = " "
        return label
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 17
        view.layer.cornerCurve = .circular
        return view
    }()
    
    private var viewModel: MessagePreviewModel?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(statusLineView)
        statusLineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(4)
        }
        
        addSubview(statusBackgroundView)
        statusBackgroundView.snp.makeConstraints { make in
            make.centerX.equalTo(statusLineView)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        addSubview(statusCircleView)
        statusCircleView.snp.makeConstraints { make in
            make.center.equalTo(statusBackgroundView)
            make.size.equalTo(12)
        }
        
        addSubview(statusWarningButton)
        statusWarningButton.snp.makeConstraints { make in
            make.center.equalTo(statusBackgroundView)
            make.height.equalTo(16)
            make.width.equalTo(19)
        }
        
        addSubview(backgroundView)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.leading.equalTo(statusLineView.snp.trailing).offset(28)
            make.trailing.equalToSuperview().inset(25)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(textLabel.snp.trailing).inset(1)
            make.top.equalTo(textLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview().inset(9 + 10)
        }
        
        addSubview(ownerLabel)
        ownerLabel.snp.makeConstraints { make in
            make.leading.equalTo(textLabel.snp.leading)
            make.top.equalTo(textLabel.snp.bottom).offset(2)
            make.trailing.equalTo(timeLabel.snp.leading)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.top).offset(-9)
            make.trailing.equalTo(textLabel).offset(11)
            make.leading.equalTo(textLabel).offset(-11)
            make.bottom.equalTo(timeLabel.snp.bottom).offset(9)
        }
    }
    
    func configure(viewModel: MessagePreviewModel) {
        self.viewModel = viewModel
        
        if self.viewModel?.warning != nil {
            statusWarningButton.isHidden = false
            statusCircleView.isHidden = true
        } else {
            statusWarningButton.isHidden = true
            statusCircleView.isHidden = false
        }
        
        textLabel.text = self.viewModel?.text
        ownerLabel.text = self.viewModel?.ownerName
        timeLabel.text = self.viewModel?.scheduleTime
    }
    
    @objc private func warningButtonTapped() {
        viewModel?.warning?.completion()
    }
}

class MessagePreviewTableViewCell: UITableViewCell {
    
    private lazy var view = MessagePreviewView()
    
    static let id = "MessageTableViewCellID"
    
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
