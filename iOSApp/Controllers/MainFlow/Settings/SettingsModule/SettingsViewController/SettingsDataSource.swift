//
//  SettingsDataSource.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 26.08.2024.
//

import UIKit

class SettingsDataSource: UITableViewDiffableDataSource<SettingsSection, SettingsRow> {
    
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .userInfoCell(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableCell.id, for: indexPath) as? UserInfoTableCell
                cell?.configure(model)
                return cell
                
            case .subscriptionBannerCell(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: SubscribtionBannerTableCell.id, for: indexPath) as? SubscribtionBannerTableCell
                cell?.configure(model)
                return cell
                
            case .botDisconnectedCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSettingsTableCell.id, for: indexPath) as? DefaultSettingsTableCell
                cell?.configure(DefaultSettingsCellModel(
                    image: UIImage(systemName: "link.badge.plus"),
                    text: "Подключиться к боту")
                )
                return cell
                
            case .botConnectedCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSettingsTableCell.id, for: indexPath) as? DefaultSettingsTableCell
                cell?.configure(DefaultSettingsCellModel(
                    image: UIImage(systemName: "checkerboard.shield"),
                    text: "Бот подкоючен")
                )
                return cell
                
            case .defaultSettingsCell(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSettingsTableCell.id, for: indexPath) as? DefaultSettingsTableCell
                cell?.configure(model)
                return cell
                
            case .logoutAppCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSettingsTableCell.id, for: indexPath) as? DefaultSettingsTableCell
                cell?.configure(DefaultSettingsCellModel(
                    image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                    text: "Выйти")
                )
                return cell
            }
        }
    }
    
}
