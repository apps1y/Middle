//
//  MainTabBarAssembly.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 11.08.2024.
//

import Foundation

final class MainTabBarAssembly {
    
    private let homeAssembly: HomeAssembly
    private let settingsAssembly: SettingsAssembly
    
    init(homeAssembly: HomeAssembly, settingsAssembly: SettingsAssembly) {
        self.homeAssembly = homeAssembly
        self.settingsAssembly = settingsAssembly
    }
    
    func assemble() -> MainTabBarController {
        let tabBar = MainTabBarController(homeAssembly: homeAssembly, settingsAssembly: settingsAssembly)
        return tabBar
    }
}
