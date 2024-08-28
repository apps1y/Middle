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
    
    /// начало анимации загрузки экрана
    func startLoading()
    
    /// конец загрузки экрана
    func finishLoading()
    
    /// отображение информации о юзере
    /// - Parameter user: модель юзера
    func show(user: UserModel)
}


// MARK: - View Controller
final class SettingsViewController: UIViewController {
    
    // MARK: UI
    private lazy var tableView: SettingsTableView = {
        let table = SettingsTableView()
        table.delegate = self
        return table
    }()
    
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var headerActivityIndicator = UIActivityIndicatorView()
    
    private lazy var headerTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var presenter: SettingsPresenterProtocol?
    
    // MARK: viewDidLoad
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
        
        headerTitleView.addSubview(headerActivityIndicator)
        headerActivityIndicator.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        headerTitleView.addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerActivityIndicator.snp.trailing).offset(7)
            make.trailing.equalToSuperview().inset(27)
        }
        
        navigationItem.titleView = headerTitleView
        
        tableView.showSubscriptionBanner = false
    }
}

// MARK: - View Protocol Realization
extension SettingsViewController: SettingsViewProtocol {
    
    func startLoading() {
        headerActivityIndicator.startAnimating()
    }
    
    func finishLoading() {
        headerActivityIndicator.stopAnimating()
    }
    
    func show(user: UserModel) {
        // emailLabel.text = user.email
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


