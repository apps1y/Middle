//
//  HomeViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import AppUI

// MARK: - View Protocol
protocol HomeViewProtocol: AnyObject {
    /// начало загрузки
    func startLoading()
    
    /// конец загрузки
    func finishLoading()
    
    /// сборка view с моделью
    func configureView(with models: [DayModel])
}

// MARK: - View Controller
final class HomeViewController: UIViewController {
    
    private lazy var calendarView: UIWeekCalendarView = {
        let calendar = UIWeekCalendarView()
        calendar.calendarDelegate = self
        return calendar
    }()
    
    private lazy var backgroundCalendarView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var messageScrollView: DaysCollectionView = {
        let view = DaysCollectionView()
        view.calendarDelegate = self
        return view
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Публикации"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        return loader
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.text = Date().dateFormatLLLLyyyy()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var warningBarButtonItem: UIBarButtonItem = {
        let image = UIImage(systemName: "bell.badge")
        let item = UIBarButtonItem(image: image, style: .plain,
                                   target: self, 
                                   action: #selector(warningBarButtonItemTapped))
        return item
    }()
    
    var presenter: HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.scrollToItem(at: IndexPath(item: 10, section: 0), at: .centeredHorizontally, animated: false)
        messageScrollView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(backgroundCalendarView)
        
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo((view.frame.width - 20) / 7)
        }
        
        backgroundCalendarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(-30)
            make.bottom.equalTo(calendarView.snp.bottom).offset(7)
        }
        
        view.addSubview(messageScrollView)
        messageScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(backgroundCalendarView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        titleView.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(6)
        }
        
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(loader.snp.trailing).offset(7)
            make.trailing.equalToSuperview().inset(27)
            make.height.equalTo(19)
            make.top.equalToSuperview().offset(6)
        }
        
        titleView.addSubview(monthLabel)
        monthLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview()
            make.height.equalTo(13)
        }
        
        navigationItem.titleView = titleView
        
        navigationItem.leftBarButtonItem = warningBarButtonItem
    }
    
    @objc private func warningBarButtonItemTapped() {
        presenter?.prepareUnravelViewShowing()
    }
}

// MARK: - View Protocol Realization
extension HomeViewController: HomeViewProtocol {
    func startLoading() {
        loader.startAnimating()
    }
    
    func finishLoading() {
        loader.stopAnimating()
    }
    
    func configureView(with models: [DayModel]) {
        messageScrollView.configure(with: models)
    }
}

extension HomeViewController: UIWeekCalendarViewDelegate {
    func didTap(on date: Date) {
        messageScrollView.newDate = date
    }
    
    func didScroll(centerDate: Date) {
        monthLabel.text = centerDate.dateFormatLLLLyyyy()
    }
}

extension HomeViewController: DaysScrollViewDelegate {
    func didScroll(to date: Date) {
        calendarView.newDate = date
    }
}
