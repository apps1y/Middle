//
//  UnravelViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.08.2024
//

import UIKit
import SnapKit

// MARK: - View Protocol
protocol UnravelViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class UnravelViewController: UIViewController {
    
    private lazy var warningBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(warningBarButtonItemTapped))
        return item
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UnravelTableViewCell.self, forCellReuseIdentifier: UnravelTableViewCell.id)
        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private var messageModelsWithUnravel: [MessagePreviewModel] = [
        MessagePreviewModel(type: .basic, text: "Доброе утро! Сегодняшний день начинается не с чашечки кофе, а с разбора ваших писем, которые вы мне прислали накануне выходных", input: [], scheduleTime: "12:34", ownerName: "Алина • Маникюрная лента", accountPhoneNumber: "", linkOnChat: "", unravel: .tooFrequentPublications),
    ]
    
    var presenter: UnravelPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Предупреждения"
        
        navigationItem.rightBarButtonItem = warningBarButtonItem
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func warningBarButtonItemTapped() {
        dismiss(animated: true)
    }
}

// MARK: - View Protocol Realization
extension UnravelViewController: UnravelViewProtocol {
    
}


// MARK: - UITableViewDataSource
extension UnravelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageModelsWithUnravel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UnravelTableViewCell.id, for: indexPath) as? UnravelTableViewCell else { return UITableViewCell() }
        cell.configure(viewModel: messageModelsWithUnravel[indexPath.row])
        return cell
    }
}


// MARK: - UITableViewDelegate
extension UnravelViewController: UITableViewDelegate {
    
}
