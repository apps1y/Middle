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
    func startLoading()
    
    func finishLoading()
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
    
    private lazy var messageScrollView: UILeafScrollView = {
        let view = UILeafScrollView()
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
        label.text = "август 2024"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
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
        let days: [DayModel] = [DayModel(messages: [
            MessagePreviewModel(type: .contact, text: "Привет", input: [], scheduleTime: "15:05", ownerName: "I L • Книжный клуб.rar", accountPhoneNumber: "", linkOnChat: "", warning: nil),
            
            MessagePreviewModel(type: .contact, text: "Это первый большой пост в нашем телеграмм канале!!! Мы давно этого ждали", input: [], scheduleTime: "15:05", ownerName: "I L • Книжный клуб.rar", accountPhoneNumber: "", linkOnChat: "", warning: WarningModel(text: "Ошибка то у Вас!!", completion: { [weak self] in
                self?.presenter?.warning(message: "{ttq")
            })),
            
            MessagePreviewModel(type: .contact, text: "Все пока, люди!", input: [], scheduleTime: "15:05", ownerName: "I L • Книжный клуб.rar", accountPhoneNumber: "", linkOnChat: "", warning: nil),
            
        ], date: Date().getDate(with: 0))]
        
        messageScrollView.configure(with: days)
        
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
    }
}

// MARK: - View Protocol Realization
extension HomeViewController: HomeViewProtocol {
    func startLoading() {
        
    }
    
    func finishLoading() {
        
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

extension HomeViewController: UILeafScrollViewDelegate {
    func didScroll(to date: Date) {
        calendarView.newDate = date
    }
}
