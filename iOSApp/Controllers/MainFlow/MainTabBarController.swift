//
//  MainTabBarController.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 17.07.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let homeAssembly: HomeAssembly
    private let settingsAssembly: SettingsAssembly
    
    init(homeAssembly: HomeAssembly, settingsAssembly: SettingsAssembly) {
        self.homeAssembly = homeAssembly
        self.settingsAssembly = settingsAssembly
        super.init(nibName: nil, bundle: nil)
        
        setupControllers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupControllers() {
        let homeVC = homeAssembly.assemble()
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        homeNavigationController.tabBarItem.title = "Главная"
        homeNavigationController.tabBarItem.image = UIImage(systemName: "list.bullet.below.rectangle")
        
        let settingsVC = settingsAssembly.assemble()
        settingsVC.viewDidLoad()
        let settingsNavigationController = UINavigationController(rootViewController: settingsVC)
        settingsNavigationController.tabBarItem.title = "Настройки"
        settingsNavigationController.tabBarItem.image = UIImage(systemName: "gear")
        
        setViewControllers([homeNavigationController, settingsNavigationController], animated: false)
    }
}
