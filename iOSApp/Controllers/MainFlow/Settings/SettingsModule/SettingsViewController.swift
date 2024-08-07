//
//  SettingsViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import AppUI

// MARK: - View Protocol
protocol SettingsViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class SettingsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.sectionHeaderHeight = 0
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    private lazy var changePasswordCell = SettingsTableCell(title: "Изменить пароль", 
                                                            systemImage: "key.viewfinder",
                                                            iconBackgroundColor: .systemGreen)
    private lazy var logoutCell = SettingsTableCell(title: "Выйти",
                                                    systemImage: "rectangle.portrait.and.arrow.right",
                                                    iconBackgroundColor: .systemPink, symbolWeight: .heavy)
    
    private lazy var addTelegramAccountCell = AddUserTableCell(title: "Добавить аккаунт", 
                                                               systemImage: "plus")
    
    private lazy var policityCell = SettingsTableCell(title: "Политика конфиденциальности", 
                                                      systemImage: "doc.text.fill",
                                                      iconBackgroundColor: .blue)
    private lazy var reviewCell = SettingsTableCell(title: "Оценить", 
                                                    systemImage: "star.fill",
                                                    iconBackgroundColor: .systemYellow)
    private lazy var shareFrendsCell = SettingsTableCell(title: "Рассказать друзьям", 
                                                         systemImage: "ellipsis.message.fill",
                                                         iconBackgroundColor: .systemOrange)
    private lazy var writeEmailCell = SettingsTableCell(title: "Написать нам", 
                                                        systemImage: "envelope.fill",
                                                        iconBackgroundColor: .systemGreen)
    
    private lazy var userInfoCell = UITableViewCell()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "ivanicloud_vanya@icloud.com"
        return label
    }()
    
    private lazy var subscriptionInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Пробный период до 21 июля"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private var telegramAccounts: [String] = ["Иван", "Карим"]
    
    var presenter: SettingsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Настройки"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userInfoCell.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.top.equalToSuperview().inset(10)
        }
        
        userInfoCell.addSubview(subscriptionInfoLabel)
        subscriptionInfoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
        }
    }
}

// MARK: - View Protocol Realization
extension SettingsViewController: SettingsViewProtocol {
    
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return telegramAccounts.count + 1
        case 3: return 1
        case 4: return 3
        case 5: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return userInfoCell
        case 1:
            return changePasswordCell
        case 2:
            if indexPath.row == telegramAccounts.count { return addTelegramAccountCell }
            else { return UserTableCell(title: telegramAccounts[indexPath.row], userImage: nil) }
        case 3:
            break
        case 4:
            if indexPath.row == 0 { return policityCell }
            else if indexPath.row == 1 { return reviewCell }
            else if indexPath.row == 2 { return shareFrendsCell }
        case 5:
            return logoutCell
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        }
        return 44
    }
}
