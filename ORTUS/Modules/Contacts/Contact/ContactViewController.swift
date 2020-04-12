//
//  ContactViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/10/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class ContactViewController: TranslatableModule, ModuleViewModel {
    var viewModel: ContactViewModel
    
    weak var contactView: ContactView! { return view as? ContactView }
    weak var tableView: UITableView! { return contactView.tableView }
    weak var photoView: CircleImageView! { return contactView.photoView }
    
    let headerViewMaxHeight: CGFloat = 220
    
    let adapter = ScrollTableViewAdapter()
        
    lazy var renderer = Renderer(
        adapter: self.adapter,
        updater: UITableViewUpdater()
    )
    
    init(viewModel: ContactViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ContactView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        EventLogger.log(.openedContact)
        
        prepareNavigationItem()
        prepareData()
        
        render()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    override func prepareLocales() {
        
    }
    
    func render() {
        renderer.render {
            Group(of: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]) { id in
                TextComponent(id: id, text: id, onSelect: nil)
            }
        }
    }
    
    var offset: CGFloat = 0
}

extension ContactViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func prepareData() {
        renderer.target = tableView
        adapter.delegate = self
        
        if let photo = viewModel.contact.photo {
            photoView.kf.setImage(with: URL(string: photo))
        }
    }
}

extension ContactViewController: ScrollTableViewAdapterDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let y = scrollView.contentOffset.y
//        let newHeight = contactView.headerHeight.constant - y
//
        let headerViewMinHeight = headerViewMaxHeight - view.safeAreaInsets.top
//
//        if newHeight > headerViewMaxHeight {
//            contactView.headerHeight.constant = headerViewMaxHeight
//            contactView.photoViewTop.constant = 0
////            photoView.transform = .identity
//        } else if newHeight < headerViewMinHeight {
//            contactView.headerHeight.constant = headerViewMinHeight
//            contactView.photoViewTop.constant = -44
////            photoView.transform = CGAffineTransform(scaleX: 0.66, y: 0.66)
//        } else {
//            contactView.headerHeight.constant = newHeight
//            contactView.photoViewTop.constant = -44 * 100 / newHeight
//
////            let photoScale: CGFloat = 0.66 * 100 / newHeight
////            print(photoScale)
////            photoView.transform = CGAffineTransform(scaleX: photoScale, y: photoScale)
//
//            scrollView.contentOffset.y = 0
//        }
        if scrollView.contentOffset.y <= headerViewMinHeight {
            contactView.headerHeight.constant = headerViewMinHeight
        } else if scrollView.contentOffset.y <= 0 {
            contactView.headerHeight.constant = headerViewMaxHeight
        } else {
            let offsetDiff = offset - scrollView.contentOffset.y
            offset = scrollView.contentOffset.y
            let newHeight = contactView.headerHeight.constant - offsetDiff
            contactView.headerHeight.constant = newHeight
        }
    }
}
