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
        view.layer.cornerRadius = 28
        return view
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
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Месяц"
        
        view.addSubview(backgroundCalendarView)
        
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo((view.frame.width - 20) / 7)
        }
        
        backgroundCalendarView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(calendarView.snp.bottom).offset(7)
        }
    }
}

// MARK: - View Protocol Realization
extension HomeViewController: HomeViewProtocol {
    
}

extension HomeViewController: UIWeekCalendarViewDelegate {
    func didTapDate(of model: WeekCalendarDateModel) {
        print(model)
    }
}
