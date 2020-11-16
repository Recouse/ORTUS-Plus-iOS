//
//  CalendarViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/22/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

protocol CalendarViewControllerDelegate: AnyObject {
    func selectedDate(on datePicker: UIDatePicker, controller: CalendarViewController)
}

class CalendarViewController: UIViewController {
    weak var calendarView: CalendarView! { return view as? CalendarView }
    weak var datePicker: UIDatePicker! { return calendarView.datePicker }
    
    weak var delegate: CalendarViewControllerDelegate?
    
    override func loadView() {
        view = CalendarView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = datePicker.bounds.size
        
        datePicker.addTarget(self, action: #selector(selectedDate), for: .valueChanged)
    }
    
    @objc func selectedDate() {
        delegate?.selectedDate(on: datePicker, controller: self)
    }
}
