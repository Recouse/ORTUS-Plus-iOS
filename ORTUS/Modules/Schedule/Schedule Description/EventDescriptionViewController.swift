//
//  EventDescriptionViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/27/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class EventDescriptionViewController: UIViewController {
    let event: Event
    
    weak var eventDescriptionView: EventDescriptionView! { return view as? EventDescriptionView }
    weak var eventView: EventComponentView! { return eventDescriptionView.eventView }
    weak var descriptionLabel: UILabel! { return eventDescriptionView.descriptionLabel }
    
    init(event: Event) {
        self.event = event
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = EventDescriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventView.titleLabel.text = event.title
        if event.allDayEvent {
            eventView.timeLabel.text = "all-day"
        } else {
            eventView.timeLabel.text = event.timeParsed
        }
        
        let description = event.description.htmlToString
        descriptionLabel.text = description
        
        let eventTitleSize = (event.title as NSString)
            .size(withAttributes: [.font: EventComponentView.titleFont])
        let eventHeight = 7 + (eventTitleSize.height < 44 ? 44 : eventTitleSize.height) + 7
        
        let descriptionSize = (description as NSString)
            .boundingRect(
                with: CGSize(
                    width: UIScreen.main.bounds.width - Global.UI.edgeInset * 2,
                    height: .greatestFiniteMagnitude),
                options: [.usesFontLeading, .usesLineFragmentOrigin],
                attributes: [.font: EventDescriptionView.descriptionFont],
                context: nil
        )
        
        preferredContentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: eventHeight + 5 + descriptionSize.height)
    }
}
