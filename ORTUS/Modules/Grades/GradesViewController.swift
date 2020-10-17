//
//  GradesViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Promises

class GradesViewController: ORTUSTableViewController, ModuleViewModel {
    var viewModel: GradesViewModel
    
    init(viewModel: GradesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userActivity = Shortcut(activity: .grades).activity
        
        EventLogger.log(.openedGrades)
        
        loadData()
    }
    
    override func prepareData() {
        super.prepareData()
        
        renderer.updater.isAnimationEnabledWhileScrolling = false
        
        navigationItem.title = L10n.Grades.title
        
        renderer.adapter.didSelect = { [unowned self] context in
            guard let semesters = self.viewModel.studyPrograms.first?.semesters else {
                return
            }
            
            let mark = semesters[context.indexPath.section].marks[context.indexPath.row]
            
            self.openMark(mark)
        }
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        guard let semesters = viewModel.studyPrograms.first?.semesters else {
            return
        }
                        
        renderer.render {
            Group(of: semesters) { semester in
                Section(
                    id: "grades",
                    header: Header(title: semester.fullName.uppercased())
                ) {
                    Group(of: semester.marks) { mark in
                        GradeComponent(mark: mark).identified(by: mark.id)
                    }
                }
            }
        }
    }
    
    func loadData(forceUpdate: Bool = false) {
        if forceUpdate {
            viewModel.loadMarks().always {
                self.render()
            }
            
            return
        }
        
        viewModel.loadCachedMarks().then { _ -> Promise<Bool> in
            self.render()
            
            return self.viewModel.loadMarks()
        }.then { _ in
            self.render()
        }
    }
    
    override func refresh() {
        loadData(forceUpdate: true)
    }
    
    func openMark(_ mark: Mark) {
        viewModel.router.openMark(mark)
    }
}
