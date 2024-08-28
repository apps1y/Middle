//
//  SettingsTableView.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 26.08.2024.
//

import UIKit

class SettingsTableView: UITableView {
    
    // MARK: - все ячейки
    private var userRow: SettingsRow = .userInfoCell(UserModel(email: "Загрузка..."))
    
    private var recoverRow: SettingsRow = {
        let model = DefaultSettingsCellModel(
            image: UIImage(systemName: "square"),
            text: "Изменить пароль"
        )
        let row = SettingsRow.defaultSettingsCell(model)
        return row
    }()
    
    private var subscriptionRow: SettingsRow = {
        let model = SubscribtionBannerCellModel()
        let row = SettingsRow.subscriptionBannerCell(model)
        return row
    }()
    
    private var telegramRow: SettingsRow = .botDisconnectedCell
    
    private var confidentiallyRow: SettingsRow = {
        let model = DefaultSettingsCellModel(
            image: UIImage(systemName: "square"),
            text: "Политика"
        )
        let row = SettingsRow.defaultSettingsCell(model)
        return row
    }()
    
    private var ratingRow: SettingsRow = {
        let model = DefaultSettingsCellModel(
            image: UIImage(systemName: "square"),
            text: "Оценить приложение"
        )
        let row = SettingsRow.defaultSettingsCell(model)
        return row
    }()
    
    private var shareRow: SettingsRow = {
        let model = DefaultSettingsCellModel(
            image: UIImage(systemName: "square"),
            text: "Рассказать друзьям"
        )
        let row = SettingsRow.defaultSettingsCell(model)
        return row
    }()
    
    private var supportRow: SettingsRow = {
        let model = DefaultSettingsCellModel(
            image: UIImage(systemName: "square"),
            text: "Написать нам"
        )
        let row = SettingsRow.defaultSettingsCell(model)
        return row
    }()
    
    private var logoutRow: SettingsRow = {
        let row = SettingsRow.logoutAppCell
        return row
    }()
    
    
    // MARK: - Ячейки в списках, которые изменяются
    private lazy var subscription: [SettingsRow] = [subscriptionRow]
    
    
    private lazy var settingsDataSource = SettingsDataSource(tableView: self)
    
    init() {
        super.init(frame: .zero, style: .insetGrouped)
        
        setup()
        snapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        register(UserInfoTableCell.self, forCellReuseIdentifier: UserInfoTableCell.id)
        register(DefaultSettingsTableCell.self, forCellReuseIdentifier: DefaultSettingsTableCell.id)
        register(SubscribtionBannerTableCell.self, forCellReuseIdentifier: SubscribtionBannerTableCell.id)
        
        sectionHeaderHeight = 0
        rowHeight = UITableView.automaticDimension
        separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }
    
    private func snapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SettingsSection, SettingsRow>()
        
        snapshot.appendSections(getSectionForSnapshot())
        
        if !subscription.isEmpty {
            snapshot.appendItems(subscription, toSection: .subscription)
        }
        
        snapshot.appendItems([userRow], toSection: .user)
        snapshot.appendItems([recoverRow], toSection: .recover)
        snapshot.appendItems([telegramRow], toSection: .telegram)
        snapshot.appendItems([
            confidentiallyRow, ratingRow, shareRow, supportRow
        ], toSection: .application)
        snapshot.appendItems([logoutRow], toSection: .logout)
        
        settingsDataSource.apply(snapshot)
    }
    
    private func getSectionForSnapshot() -> [SettingsSection] {
        var sections: [SettingsSection] = [.user, .recover, .telegram, .application, .logout]
        if !subscription.isEmpty {
            sections.insert(.subscription, at: 2)
        }
        return sections
    }
    
    // MARK: взаимодействие с tableView
    
    public var showSubscriptionBanner: Bool = true {
        didSet {
            if showSubscriptionBanner {
                subscription = [subscriptionRow]
            } else {
                subscription = []
            }
            snapshot()
        }
    }
    
    public var isBotConnecting: Bool = false {
        didSet {
            if isBotConnecting {
                telegramRow = .botConnectedCell
            } else {
                telegramRow = .botDisconnectedCell
            }
            snapshot()
        }
    }
}
