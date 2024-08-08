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
    func startLoading()
    
    func finishLoading()
    
    func show(accounts: [String])
}

// MARK: - View Controller
final class SettingsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.sectionHeaderHeight = 0
        table.rowHeight = UITableView.automaticDimension
        table.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        table.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
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
    
    private lazy var policityCell = SettingsTableCell(title: "Конфиденциальность",
                                                      systemImage: "doc.text.fill",
                                                      iconBackgroundColor: UIColor(red: 56/255, green: 169/255, blue: 218/255, alpha: 1.0))
    private lazy var reviewCell = SettingsTableCell(title: "Оценить",
                                                    systemImage: "star.fill",
                                                    iconBackgroundColor: .systemYellow)
    private lazy var shareFrendsCell = SettingsTableCell(title: "Рассказать друзьям", 
                                                         systemImage: "ellipsis.message.fill",
                                                         iconBackgroundColor: .systemOrange)
    private lazy var writeEmailCell = SettingsTableCell(title: "Написать нам", 
                                                        systemImage: "envelope.fill",
                                                        iconBackgroundColor: .systemGreen)
    
    private lazy var userInfoCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }()
    
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
    
    private lazy var subscribtionCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }()
    
    private lazy var subscribtionBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "subscriptionButton")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var subscribtionLabel: UILabel = {
        let label = UILabel()
        label.text = "Подписка"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var loader = UIActivityIndicatorView()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var telegramAccounts: [String] = ["Иван", "Карим", "Арсений"]
    
    var presenter: SettingsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
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
        
        subscribtionCell.addSubview(subscribtionBackground)
        subscribtionBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subscribtionCell.addSubview(subscribtionLabel)
        subscribtionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleView.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(loader.snp.trailing).offset(7)
            make.trailing.equalToSuperview().inset(27)
        }
        
        navigationItem.titleView = titleView
    }
}

// MARK: - View Protocol Realization
extension SettingsViewController: SettingsViewProtocol {
    func startLoading() {
        
    }
    
    func finishLoading() {
    }
    
    func show(accounts: [String]) {
        
    }
    
    
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
            return subscribtionCell
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
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            presenter?.changePassword()
        case (2, telegramAccounts.count):
            presenter?.addNewTelegramAccount()
        case (3, 0):
            presenter?.openSubscribeInformation()
        case (4, 0):
            presenter?.openConfidentional()
        case (4, 1):
            presenter?.ratingApp()
        case (4, 2):
            presenter?.shareWithFriends()
        case (5, 0):
            presenter?.logoutAccount()
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 2 && indexPath.row != telegramAccounts.count {
            let deleteAction = UIContextualAction(style: .destructive, title: "Выйти") { [weak self] (action, view, completionHandler) in
                self?.telegramAccounts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                completionHandler(true)
            }
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
        return nil
    }
}
