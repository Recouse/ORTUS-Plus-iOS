//
//  ScheduleViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import SafariServices
import Promises

class ScheduleViewController: Module, ModuleViewModel {
    var viewModel: ScheduleViewModel
    
    weak var scheduleView: ScheduleView! { return view as? ScheduleView }
    weak var tableView: UITableView! { return scheduleView.tableView }
    
    var refreshControl: UIRefreshControl!
    
    var calendarBarButtonItem: UIBarButtonItem!
    
    lazy var calendarController: CalendarViewController = {
        let controller = CalendarViewController()
        controller.delegate = self
        controller.modalPresentationStyle = .popover
        
        return controller
    }()
    
    lazy var adapter = ScheduleTableViewAdapter(dataSource: self, delegate: self)
    
    lazy var renderer = Renderer(
        adapter: self.adapter,
        updater: UITableViewUpdater()
    )
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = LatviaDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
    
    var selectedDate = Date() {
        didSet {
            updateCalendarBarButtonItem()
            loadData(forceUpdate: true)
        }
    }
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ScheduleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == UserDefaults.Key.showEvents.name {
            loadData()
        }
    }
    
    func loadData(forceUpdate: Bool = false) {
        if forceUpdate {
            viewModel.loadSchedule(date: selectedDate).always {
                self.render(animated: true)
            }
            
            return
        }
        
        viewModel.loadCachedSchedule().then { _ -> Promise<Bool> in
            self.render()
            
            return self.viewModel.loadSchedule(date: self.selectedDate)
        }.then { _ in
            self.render()
        }
    }
    
    func render(animated: Bool = false) {
        self.refreshControl.endRefreshing()
        
        var data: [Section] = []

        for (key, schedule) in viewModel.schedule {
            data.append(
                Section(
                    id: key,
                    header: ViewNode(ScheduleDateHeader(title: key)),
                    cells: schedule.compactMap {
                        if let event = $0.item(as: Event.self) {
                            return CellNode(EventComponent(id: event.title, event: event))
                        }

                        if let lecture = $0.item(as: Lecture.self) {
                            return CellNode(LectureComponent(id: lecture.id, lecture: lecture))
                        }

                        return nil
                    }
                )
            )
        }
        
        if data.isEmpty {
            data.append(
                Section(id: "empty", header: ViewNode(
                    StateComponent(
                        image: Asset.Images.calendarFlatline.image,
                        primaryText: "No upcoming lessons",
                        secondaryText: "Check the schedule for a week or pull to refresh.",
                        height: view.safeAreaLayoutGuide.layoutFrame.height - 44 - 25
                    )
                ))
            )
        }

        renderer.render {
            Group(of: data) { section in
                section
            }
        }
        
        scrollToSelectedDay(animated: animated)
    }
    
    @objc func selectScheduleGrouping() {
        render()
    }
    
    @objc func refresh() {
        loadData(forceUpdate: true)
    }
    
    func open(event: Event) {
        EventLogger.log(.openedEvent)
        
        OAuth.refreshToken().then { accessTokenEncrypted in
            guard let url = event.link.generatePinAuthURL(withToken: accessTokenEncrypted) else {
                return
            }
            
            let controller = SFSafariViewController(url: url)
            controller.delegate = self
            
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @objc func showCalendar() {
        calendarController.popoverPresentationController?.barButtonItem = calendarBarButtonItem
        calendarController.popoverPresentationController?.delegate = self
        
        present(calendarController, animated: true, completion: nil)
    }
    
    func updateCalendarBarButtonItem() {
        let day = Calendar.current.component(.day, from: selectedDate)
        
        calendarBarButtonItem.image = UIImage(systemName: "\(day).circle")
    }
    
    func scrollToSelectedDay(animated: Bool = false) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let day = Calendar.current.component(.day, from: selectedDate)
        
        for (index, schedule) in viewModel.schedule.enumerated() {
            guard let scheduleDate = dateFormatter.date(from: schedule.key) else {
                continue
            }
            
            if day == Calendar.current.component(.day, from: scheduleDate) {
                tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: animated)
                break
            }
        }
    }
}

extension ScheduleViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        
        calendarBarButtonItem = UIBarButtonItem(
            image: nil,
            style: .plain,
            target: self,
            action: #selector(showCalendar)
        )
        updateCalendarBarButtonItem()
        
        navigationItem.rightBarButtonItem = calendarBarButtonItem
    }
    
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func prepareData() {
        renderer.target = tableView
        renderer.updater.isAnimationEnabled = false
        renderer.updater.isAnimationEnabledWhileScrolling = false
        
        viewModel.sharedUserDefaults?.addObserver(
            self,
            forKeyPath: UserDefaults.Key.showEvents.name,
            options: .new,
            context: nil
        )
        
        title = L10n.Schedule.title
    }
}

extension ScheduleViewController: ScheduleTableViewAdapterDataSource, ScheduleTableViewAdapterDelegate {
    func item(for indexPath: IndexPath) -> ScheduleItem? {
        let cell = renderer.data[indexPath.section].cells[indexPath.row]
        
        if let event = cell.component(as: EventComponent.self)?.event {            
            return ScheduleItem(event, time: event.time)
        }
        
        if let lecture = cell.component(as: LectureComponent.self)?.lecture {
            return ScheduleItem(lecture, time: lecture.timeFrom)
        }
        
        return nil
    }
    
    func openLink(_ url: URL) {
        viewModel.router.openBrowser(url.absoluteString)
    }
}

extension ScheduleViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

extension ScheduleViewController: CalendarViewControllerDelegate {
    func selectedDate(on datePicker: UIDatePicker, controller: CalendarViewController) {
        controller.dismiss(animated: true, completion: nil)
        
        selectedDate = datePicker.date
    }
}

extension ScheduleViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

