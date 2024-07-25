//
//  SettingsPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

protocol SettingsPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterInput
    
    private let networkService: NetworkMainProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    
    private var completion: () -> Void

    init(view: SettingsViewProtocol?, router: SettingsRouterInput, networkService: NetworkMainProtocol, keychainBearerManager: KeychainBearerProtocol, completion: @escaping () -> Void) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.completion = completion
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
