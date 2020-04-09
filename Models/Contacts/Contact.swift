//
//  Contact.swift
//  Models
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public struct Contact: Codable {
    public let id: String
    public let address: String?
    public let cellPhone: String?
    public let email: String?
    public let firstName, lastName: String?
    public let name: String
    public let officeHours: String?
    public let phone, photo, previewPhoto: String?
    public let positions: [Position]?
    public let priority: Int
}

public struct Contacts: Codable {
    public let contacts: [Contact]
}

public typealias ContactsResponse = Response<Contacts>
