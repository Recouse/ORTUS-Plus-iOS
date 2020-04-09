//
//  ContactsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import Foundation
import Models
import Storage
import Promises

class ContactsViewModel: ViewModel {
    typealias SortedContacts = [String: [Contact]]
    
    let router: ContactsRouter.Routes
    
    var sortedKeys: [String] = []
    
    var contacts: SortedContacts = [:]
    
    let storage: CodableStorage = {
        let path = URL(fileURLWithPath: NSTemporaryDirectory())
        let disk = DiskStorage(path: path)
        let storage = CodableStorage(storage: disk)
        
        return storage
    }()
    
    init(router: ContactsRouter.Routes) {
        self.router = router
    }
    
    func loadContacts() -> Promise<SortedContacts> {
        if let cached: Contacts = try? storage.fetch(for: Global.Key.contactsCache) {
            sortContacts(from: cached)
            
            return Promise(self.contacts)
        }
        
        return Promise { fulfill, reject in
            APIClient.performRequest(
                ContactsResponse.self,
                route: ContactsApi.publicContacts
            ).then { response in
                try? self.storage.save(response.result, for: Global.Key.contactsCache)
                
                self.sortContacts(from: response.result)
                
                fulfill(self.contacts)
            }.catch {
                dump($0)
                reject($0)
            }
        }
    }
    
    private func sortContacts(from list: Contacts) {
        let sortedContacts = list.contacts.sorted(by: {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        })
        self.contacts = Dictionary(grouping: sortedContacts, by: { String($0.name.prefix(1)) })
        self.sortedKeys = self.contacts.keys.sorted(by: {
            $0.localizedCaseInsensitiveCompare($1) == .orderedAscending
        })
    }
}
