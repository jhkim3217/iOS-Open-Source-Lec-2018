//
//  ViewController.swift
//  Calendar
//
//  Created by wannabewize on 2018. 6. 19..
//  Copyright © 2018년 wannabewize. All rights reserved.
//

import UIKit
import CVCalendar

typealias Todo = (title: String, date: CVDate)

class ViewController: UIViewController {
    
    let todos: [Todo] = [
        Todo(title: "Todo1(06/20)", date: CVDate.init(day: 20, month: 6, week: 0, year: 2018)),
        Todo(title: "Todo2(06/20)", date: CVDate.init(day: 20, month: 6, week: 0, year: 2018)),
        Todo(title: "Todo3(06/22)", date: CVDate.init(day: 22, month: 6, week: 0, year: 2018)),
        Todo(title: "Todo4(07/02)", date: CVDate.init(day: 2, month: 7, week: 0, year: 2018)),
        Todo(title: "Todo5(07/03)", date: CVDate.init(day: 3, month: 7, week: 0, year: 2018)),
        Todo(title: "Todo6(07/04)", date: CVDate.init(day: 4, month: 7, week: 0, year: 2018))
    ]
    var dayTodos: [Todo] = []
    func todos(at date: CVDate) -> [Todo] {
        return todos.filter({ (todo) -> Bool in
            return todo.date.year == date.year && todo.date.month == date.month && todo.date.day == date.day
        })
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!

    // 이동
    @IBAction func showPreviousRange(_ sender: Any) {
        calendarView.loadPreviousView()
    }
    
    @IBAction func showNextRange(_ sender: Any) {
        calendarView.loadNextView()
    }
    
    // 오늘 날짜로 이동
    @IBAction func showToday(_ sender: Any) {
        calendarView.toggleCurrentDayView()
    }
    
    // 년/월 표시
    func presentedDateUpdated(_ date: CVDate) {
        monthLabel.text = "\(date.year)년 \(date.month)월"
    }

    override func viewDidAppear(_ animated: Bool) {
        monthLabel.text = "\(calendarView.presentedDate.year)년 \(calendarView.presentedDate.month)월"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        calendarMenuView.commitMenuViewUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// CVCalendarDelegates
extension ViewController : CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    @IBAction func viewModeChange(_ sender: UISegmentedControl) {
        let mode: CalendarMode = sender.selectedSegmentIndex == 0 ? .monthView : .weekView
        calendarView.changeMode(mode)
    }
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    // dotMarker
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        let todoAtDay = todos(at: dayView.date!)
        return todoAtDay.count > 0
    }
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
        return [UIColor.red]
    }
    
    // 날짜 선택
    func shouldSelectDayView(_ dayView: DayView) -> Bool {
        return true
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        // 테이블 뷰 로딩 전에도 동작한다.
        if tableView != nil, let selected = dayView.date {
            dayTodos = todos(at: selected)
            tableView.reloadData()
        }
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        let todo = dayTodos[indexPath.row]
        
        cell.textLabel?.text = todo.title
        
        return cell
    }
}

