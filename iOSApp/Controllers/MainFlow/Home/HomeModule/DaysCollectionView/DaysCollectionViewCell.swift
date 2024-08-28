//
//  UILeafScrollViewCell.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 18.08.2024.
//

import UIKit
import SnapKit

/// DayView configure
protocol IDayView: UIView {
    /// повторная сборка с моделью
    func configure(viewModel: DayModel)
}

class DayView: UIView, IDayView {
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(MessagePreviewTableViewCell.self, forCellReuseIdentifier: MessagePreviewTableViewCell.id)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        table.isHidden = false
        return table
    }()
    
    private lazy var noMessagesLabel: UILabel = {
        let label = UILabel()
        label.text = "Сообщений нет"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private var dayModel: DayModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        addSubview(noMessagesLabel)
        noMessagesLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(viewModel: DayModel) {
        dayModel = viewModel
        tableView.reloadData()
        
        tableView.isHidden = dayModel?.messages.isEmpty ?? true
        noMessagesLabel.isHidden = !(dayModel?.messages.isEmpty ?? true)
    }
}

extension DayView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayModel?.messages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessagePreviewTableViewCell.id, for: indexPath) as? MessagePreviewTableViewCell else { return UITableViewCell() }
        guard let dayModel else { return UITableViewCell() }
        cell.configure(viewModel: dayModel.messages[indexPath.row])
        return cell
    }
}

extension DayView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tap on message
    }
}

class DaysCollectionViewCell: UICollectionViewCell {
    
    private lazy var view = DayView()
    
    static let id = "UIDaysScrollViewCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: DayModel) {
        view.configure(viewModel: model)
    }
}
