//
//  UILeafScrollView.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 18.08.2024.
//

import UIKit
import SnapKit
import AppUI

protocol DaysScrollViewDelegate: AnyObject {
    /// Нажатие на ячейку
    /// - Parameter model: модель дня на который  нажали
    func didScroll(to date: Date)
}

class DaysCollectionView: UICollectionView {
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    weak var calendarDelegate: DaysScrollViewDelegate?
    
    private var allDays: [DayModel] = []
    private var actualDays: [DayModel] = []
    
    private var selectedDate: Date = Date()
    
    var newDate: Date {
        get {
            return selectedDate
        } set {
            refreshWithAnimation(date: newValue)
        }
    }
    
    init() {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        register(DaysCollectionViewCell.self, forCellWithReuseIdentifier: DaysCollectionViewCell.id)
        backgroundColor = .clear
        bounces = false
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        isPagingEnabled = true
        delegate = self
        dataSource = self
        refreshAroundDays(offset: 0)
    }
    
    public func configure(with days: [DayModel]) {
        allDays = days
        refreshAroundDays(offset: 0)
        reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= 0 {
            refreshAroundDays(offset: -1)
        }
        
        if scrollView.contentOffset.x >= self.frame.width * 2 {
            refreshAroundDays(offset: 1)
        }
    }
    
    private func refreshAroundDays(offset: Int) {
        let nowDate = selectedDate.getDate(with: offset)
        selectedDate = nowDate
        calendarDelegate?.didScroll(to: selectedDate)
        let actualDays = getThreeDays(with: nowDate)
        self.actualDays = actualDays
        reloadData()
        scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    private func getThreeDays(with centerDate: Date) -> [DayModel] {
        let dayBefore = centerDate.getDate(with: -1)
        let dayModelBefore: DayModel = allDays.first {
            $0.date.dateFormatddMMyyyy() == dayBefore.dateFormatddMMyyyy()
        } ?? DayModel(messages: [], date: dayBefore)
        
        let dayCurent = centerDate.getDate(with: 0)
        let dayModelCurent: DayModel = allDays.first {
            $0.date.dateFormatddMMyyyy() == dayCurent.dateFormatddMMyyyy()
        } ?? DayModel(messages: [], date: dayCurent)
        
        let dayAfter = centerDate.getDate(with: 1)
        let dayModelAfter: DayModel = allDays.first {
            $0.date.dateFormatddMMyyyy() == dayAfter.dateFormatddMMyyyy()
        } ?? DayModel(messages: [], date: dayAfter)
        
        return [dayModelBefore, dayModelCurent, dayModelAfter]
    }
    
    public func refreshWithAnimation(date: Date) {
        if date > selectedDate {
            selectedDate = date.getDate(with: -1)
            actualDays[2] = allDays.first {
                $0.date.dateFormatddMMyyyy() == date.dateFormatddMMyyyy()
            } ?? DayModel(messages: [], date: date)
            scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        } else if date < selectedDate {
            selectedDate = date.getDate(with: 1)
            actualDays[0] = allDays.first {
                $0.date.dateFormatddMMyyyy() == date.dateFormatddMMyyyy()
            } ?? DayModel(messages: [], date: date)
            scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension DaysCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actualDays.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysCollectionViewCell.id, for: indexPath) as? DaysCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(model: actualDays[indexPath.item])
        return cell
    }
}

extension DaysCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
}

