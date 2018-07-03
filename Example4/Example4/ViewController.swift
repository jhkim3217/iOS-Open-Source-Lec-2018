//
//  ViewController.swift
//  Example4
//
//  Created by 김종현 on 2018. 7. 2..
//  Copyright © 2018년 김종현. All rights reserved.
//

import UIKit
import CVCalendar

class ViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    func presentationMode() -> CalendarMode {
        return CVCalendarViewPresentationMode.monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calendarView.delegate = self
        calendarMenuView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.commitCalendarViewUpdate()
        calendarMenuView.commitMenuViewUpdate()
    }

}

