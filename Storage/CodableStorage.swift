//
//  CodableStorage.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public class CodableStorage {
    private let storage: DiskStorage
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    public init(
        storage: DiskStorage,
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init()
    ) {
        self.storage = storage
        self.decoder = decoder
        self.encoder = encoder
    }

    public func fetch<T: Decodable>(for key: String) throws -> T {
        let data = try storage.fetchValue(for: key)
        return try decoder.decode(T.self, from: data)
    }

    public func save<T: Encodable>(_ value: T, for key: String) throws {
        let data = try encoder.encode(value)
        try storage.save(value: data, for: key)
    }
    
    public func remove(for key: String) throws {
        try storage.remove(for: key)
    }
}
