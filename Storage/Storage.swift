//
//  Storage.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public typealias Handler<T> = (Result<T, Error>) -> Void

public protocol ReadableStorage {
    func fetchValue(for key: String) throws -> Data
    func fetchValue(for key: String, handler: @escaping Handler<Data>)
}

public protocol WritableStorage {
    func save(value: Data, for key: String) throws
    func save(value: Data, for key: String, handler: @escaping Handler<Data>)
}

public protocol RemovableStorage {
    func remove(for key: String) throws
    func remove(for key: String, handler: @escaping Handler<Bool>)
}

public typealias Storage = ReadableStorage & WritableStorage & RemovableStorage
