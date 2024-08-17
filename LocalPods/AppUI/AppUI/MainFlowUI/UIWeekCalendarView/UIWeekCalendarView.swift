//
//  UIWeekCalendarView.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 17.08.2024.
//

import UIKit
import SnapKit

public protocol UIWeekCalendarViewDelegate: AnyObject {
    
    /// Нажатие на ячейку
    /// - Parameter model: модель дня на который  нажали
    func didTapDate(of model: WeekCalendarDateModel)
}

public final class UIWeekCalendarView: UICollectionView {
    
    public weak var calendarDelegate: UIWeekCalendarViewDelegate?
    private let calendarManager = CalendarManager()
    
    private var centerDate = Date()
    private var daysArray = [WeekCalendarDateModel]()
    
    private var selectedDateModel = Date().convertDateToModel()
    
    private let collectionLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        
        setupLayout()
        configure()
        setDelegates()
        
        register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.id)
        
        centerDate = calendarManager.getCenteredDate(with: Date())
        updateData(offset: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.scrollDirection = .horizontal
    }
    
    private func configure() {
        backgroundColor = .clear
        bounces = false
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        isPagingEnabled = true
    }
    
    private func setDelegates() {
        delegate = self
        dataSource = self
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= 0 {
            updateData(offset: -7)
        }
        
        if scrollView.contentOffset.x >= self.frame.width * 2 {
            updateData(offset: 7)
        }
    }
    
    private func updateData(offset: Int) {
        centerDate = centerDate.getDate(with: offset)
        let days = calendarManager.getWeekForCalendar(date: centerDate)
        daysArray = days
        reloadData()
        scrollToItem(at: IndexPath(item: 10, section: 0), at: .centeredHorizontally, animated: false)
    }
}

extension UIWeekCalendarView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.id, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        let dateModel = daysArray[indexPath.row]
        cell.configure(dateModel, isTapped: selectedDateModel.dateString == dateModel.dateString)
        return cell
    }
}

extension UIWeekCalendarView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dateModel = daysArray[indexPath.row]
        calendarDelegate?.didTapDate(of: dateModel)
        selectedDateModel = dateModel
        collectionView.reloadData()
    }
}

extension UIWeekCalendarView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 7,
                      height: collectionView.frame.height)
    }
}

