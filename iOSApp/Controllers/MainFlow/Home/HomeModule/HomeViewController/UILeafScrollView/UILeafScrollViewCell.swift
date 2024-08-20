//
//  UILeafScrollViewCell.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 18.08.2024.
//

import UIKit
import SnapKit

class UILeafScrollViewCell: UICollectionViewCell {
    
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
        return table
    }()
    
    private lazy var noMessagesView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "")
        return view
    }()
    
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
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
    }
    
    func configure(model: DayModel) {
        dayModel = model
        tableView.reloadData()
    }
}

extension UILeafScrollViewCell: UITableViewDataSource {
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

extension UILeafScrollViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(1)
    }
}
