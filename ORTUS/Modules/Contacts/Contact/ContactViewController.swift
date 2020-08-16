//
//  ContactViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/10/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import MessageUI
import MapKit

class ContactViewController: Module, ModuleViewModel {
    var viewModel: ContactViewModel
    
    weak var contactView: ContactView! { return view as? ContactView }
    weak var tableView: UITableView! { return contactView.tableView }
    weak var photoView: CircleImageView! { return contactView.photoView }
    weak var nameLabel: UILabel! { return contactView.nameLabel }
    weak var emailButton: UIButton! { return contactView.emailButton }
    weak var callButton: UIButton! { return contactView.callButton }
    weak var directionsButton: UIButton! { return contactView.directionsButton }
    
    let headerViewMaxHeight: CGFloat = Global.UI.isIphoneX ? 240 : 210
    
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
        
        EventLogger.log(.openedContact(id: viewModel.contact.id))
        
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
    
    func render() {
        var components: [CellNode] = []
        var positions: [Section] = []
        
        if let email = viewModel.contact.email {
            components.append(CellNode(ContactInfoComponent(id: "email", type: .email, description: email)))
        }
        
        if let phone = viewModel.contact.phone {
            components.append(CellNode(ContactInfoComponent(id: "phone", type: .phone, description: phone)))
        }
        
        if let phone = viewModel.contact.cellPhone {
            components.append(CellNode(ContactInfoComponent(id: "mobile", type: .phone, description: phone)))
        }
        
        if let address = viewModel.contact.address {
            components.append(CellNode(ContactInfoComponent(id: "address", type: .address, description: address)))
        }
        
        if let contactPositions = viewModel.contact.positions {
            contactPositions.forEach {
                positions.append(
                    Section(
                        id: $0.department,
                        cells: [
                            CellNode(ContactInfoComponent(id: "department", description: $0.department)),
                            CellNode(ContactInfoComponent(id: "position", description: $0.position)),
                            $0.phone != nil ? CellNode(ContactInfoComponent(id: "phone", type: .phone, description: $0.phone!)) : nil
                        ],
                        footer: ViewNode(Footer())
                    )
                )
            }
        }
        
        var sections: [Section] = [
            Section(id: "contact", cells: components, footer: ViewNode(Footer()))
        ]
        
        sections.append(contentsOf: positions)
        
        renderer.render(sections)
    }
    
    @objc func sendEmail() {
        guard let email = viewModel.contact.email else {
            return
        }
        
        composeMail(to: email)
    }
    
    @objc func makeCall() {
        guard let phone = viewModel.contact.phone ?? viewModel.contact.cellPhone else {
            return
        }
        
        openPhoneURL(phone)
    }
    
    @objc func openMap() {
        guard let address = viewModel.contact.address else {
            return
        }
        
        openMaps(withAddress: address)
    }
    
    func selected(_ component: ContactInfoComponent) {
        switch component.type {
        case .email:
            composeMail(to: component.description)
        case .phone:
            openPhoneURL(component.description)
        case .address:
            openMaps(withAddress: component.description)
        default:
            break
        }
    }
    
    func openPhoneURL(_ phone: String) {
        guard let phoneURL = URL(string: "tel://\(phone)") else {
            return
        }
        
        guard UIApplication.shared.canOpenURL(phoneURL) else {
            return
        }
        
        UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
    }
    
    func composeMail(to email: String) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.setToRecipients([email])

        present(mailController, animated: true)
    }
    
    func openMaps(withAddress address: String) {
        let alert = OpenMapDirections.openMapAlertController(
            address: address,
            title: "Open In",
            message: nil
        )
        present(alert, animated: true, completion: nil)
    }
}

extension ContactViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func prepareData() {
        renderer.target = tableView
        adapter.delegate = self
        
        adapter.didSelect = { [unowned self] context in
            guard let component = context.node.component(as: ContactInfoComponent.self) else {
                return
            }
            
            self.selected(component)
        }
        
        if let photo = viewModel.contact.photo {
            photoView.kf.setImage(with: URL(string: photo))
        }
        
        nameLabel.text = viewModel.contact.name
        
        emailButton.isEnabled = viewModel.contact.email != nil
        emailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        
        callButton.isEnabled = viewModel.contact.phone ?? viewModel.contact.cellPhone != nil
        callButton.addTarget(self, action: #selector(makeCall), for: .touchUpInside)
        
        directionsButton.isEnabled = viewModel.contact.address != nil
        directionsButton.addTarget(self, action: #selector(openMap), for: .touchUpInside)
    }
}

extension ContactViewController: ScrollTableViewAdapterDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newHeight = contactView.headerHeight.constant - scrollView.contentOffset.y
        
        let headerViewMinHeight: CGFloat = headerViewMaxHeight - view.safeAreaInsets.top + (Global.UI.isIphoneX ? 25 : 5)

        if newHeight > headerViewMaxHeight {
            contactView.headerHeight.constant = headerViewMaxHeight
        } else if newHeight < headerViewMinHeight {
            contactView.headerHeight.constant = headerViewMinHeight
        } else {
            contactView.headerHeight.constant = newHeight
            scrollView.contentOffset.y = 0
        }
    }
}

extension ContactViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
