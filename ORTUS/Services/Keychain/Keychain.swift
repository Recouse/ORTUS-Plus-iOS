//
//  Keychain.swift
//  ORTUS
//
//  Created by Firdavs on 08/11/2021.
//  Copyright © 2021 Firdavs. All rights reserved.
//

import Foundation

enum KeychainError: Error {
    case noData
    case unexpectedData
    case unhandledError(status: OSStatus)
}

class Keychain {
    
    struct Key {
        let name: String
        
        init(_ name: String) {
            self.name = name
        }
    }
    
    let serviceName: String
    
    private static let defaultServiceName: String = {
        Bundle.main.bundleIdentifier ?? "ORTUS-Plus"
    }()
    
    static let `default` = Keychain()
    
    init(serviceName: String) {
        self.serviceName = serviceName
    }
    
    convenience init() {
        self.init(serviceName: Keychain.defaultServiceName)
    }
    
    func get(for key: Keychain.Key) throws -> String {
        let query = query(for: key, returnData: true) as CFDictionary
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        switch status {
        case errSecSuccess:
            let data = result as! Data
            return String(decoding: data, as: UTF8.self)
        case errSecItemNotFound:
            throw KeychainError.noData
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func set(_ value: String, for key: Keychain.Key) throws {
        try set(Data(value.utf8), for: key)
    }
    
    func remove(for key: Keychain.Key) throws {
        try delete(for: key)
    }
    
    private func set(_ data: Data, for key: Keychain.Key) throws {
        let query = query(for: key, data: nil) as CFDictionary
        let status = SecItemCopyMatching(query, nil)
        
        switch status {
        case errSecSuccess:
            try update(data, for: key)
        case errSecItemNotFound:
            try add(data, for: key)
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    private func update(_ data: Data, for key: Keychain.Key) throws {
        let query = query(for: key) as CFDictionary
        let attributes = attributes(data: data) as CFDictionary
        let status = SecItemUpdate(query, attributes)
        
        switch status {
        case errSecSuccess:
            ()
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    private func add(_ data: Data, for key: Keychain.Key) throws {
        let query = query(for: key, data: data) as CFDictionary
        let status = SecItemAdd(query, nil)
        
        switch status {
        case errSecSuccess:
            ()
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    private func delete(for key: Keychain.Key) throws {
        let query = query(for: key) as CFDictionary
        let status = SecItemDelete(query)
        
        switch status {
        case errSecSuccess, errSecItemNotFound:
            ()
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    private func query(
        for key: Keychain.Key,
        data: Data? = nil,
        returnData: Bool = false
    ) -> [String: Any] {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.name
        ]
        
        if let data = data {
            query[kSecValueData as String] = data
        }
        
        if returnData {
            query[kSecReturnData as String] = true
            query[kSecMatchLimit as String] = kSecMatchLimitOne
        }
        
        return query
    }
    
    private func attributes(data: Data) -> [String: Any] {
        let query: [String: Any] = [
            kSecValueData as String: data
        ]
        
        return query
    }
    
    subscript(key: Keychain.Key) -> String? {
        get {
            try? get(for: key)
        }
        set {
            if let value = newValue {
                try? set(value, for: key)
            } else {
                try? remove(for: key)
            }
        }
    }
}

extension Keychain.Key {
    static let accessToken = Keychain.Key("access_token")
    static let refreshToken = Keychain.Key("refresh_token")
    static let accessTokenEncrypted = Keychain.Key("access_token_encrypted")
    static let tokenExpiresOn = Keychain.Key("expires_on")
    static let ortusPinCode = Keychain.Key("ortus_pin_code")
}
