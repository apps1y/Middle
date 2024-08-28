//
//  SettingsTableModels.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 26.08.2024.
//

import UIKit

enum SettingsSection {
    case user
    case recover
    case subscription
    case telegram
    case application
    case logout
}


enum SettingsRow: Hashable {
    case userInfoCell(UserModel)
    
    case subscriptionBannerCell(SubscribtionBannerCellModel)
    
    case botDisconnectedCell
    case botConnectedCell
    
    case defaultSettingsCell(DefaultSettingsCellModel)
    
    case logoutAppCell
}


