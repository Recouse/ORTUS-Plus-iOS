//
//  CalendarView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/22/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.calendar.firstWeekday = 2
        
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(datePicker)
        datePicker.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
