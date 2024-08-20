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
        // setupTabBarView()
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
        let settingsNavigationController = UINavigationController(rootViewController: settingsVC)
        settingsNavigationController.tabBarItem.title = "Настройки"
        settingsNavigationController.tabBarItem.image = UIImage(systemName: "gear")
        
        setViewControllers([homeNavigationController, settingsNavigationController], animated: false)
    }
    
    private func setupTabBarView() {
        tabBar.isTranslucent = true
        
        // Удаляем любые ранее установленные фоны и тени
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()

        // Создаем эффект размытия
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Добавляем эффект размытия на фон tabBar
        tabBar.insertSubview(blurEffectView, at: 0)
        
        // Добавляем полоску сверху tabBar
        let topLineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: 0.4))
        topLineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        topLineView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        
        tabBar.addSubview(topLineView)
    }
}
