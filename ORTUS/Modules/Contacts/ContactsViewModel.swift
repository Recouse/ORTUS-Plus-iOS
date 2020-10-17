//
//  ContactsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import Foundation
import Promises

enum ContactsFilter: String, CaseIterable {
    case my = "contacts.my"
    case all = "contacts.all"
}

class ContactsViewModel: ViewModel {
    typealias SortedContacts = [String: [Contact]]
    
    let router: ContactsRouter.Routes
    
    var prioritizedSortedKeys: [String] = []
    
    var sortedKeys: [String] = []
    
    var prioritizedContacts: SortedContacts = [:]
    
    var contacts: SortedContacts = [:]
    
    init(router: ContactsRouter.Routes) {
        self.router = router
    }
    
    func loadContacts() -> Promise<SortedContacts> {
        if let cached = try? Cache.shared.fetch(Contacts.self, forKey: Global.Key.contactsCache) {
            sortContacts(from: cached)
            
            return Promise(self.contacts)
        }
        
        return Promise { fulfill, reject in
            APIClient.performRequest(
                ContactsResponse.self,
                route: ContactsApi.publicContacts
            ).then { response in
                Cache.shared.save(response.result, forKey: Global.Key.contactsCache)
                
                self.sortContacts(from: response.result)
                
                fulfill(self.contacts)
            }.catch {
                reject($0)
            }
        }
    }
    
    private func sortContacts(from list: Contacts) {
        let prioritizedSortedContacts = list.contacts
            .filter { $0.priority == 1 }
            .sorted(by: {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            })
        let sortedContacts = list.contacts.sorted(by: {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        })
        
        self.prioritizedContacts = Dictionary(grouping: prioritizedSortedContacts, by: { String($0.name.prefix(1)) })
        self.contacts = Dictionary(grouping: sortedContacts, by: { String($0.name.prefix(1)) })
        
        self.prioritizedSortedKeys = self.prioritizedContacts.keys.sorted(by: {
            $0.localizedCaseInsensitiveCompare($1) == .orderedAscending
        })
        self.sortedKeys = self.contacts.keys.sorted(by: {
            $0.localizedCaseInsensitiveCompare($1) == .orderedAscending
        })
    }
}
