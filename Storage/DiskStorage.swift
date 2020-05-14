//
//  DiskStorage.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public enum StorageError: Error {
    case notFound
    case cantWrite(Error)
}

public class DiskStorage {
    public static let queueLabel = "DiskCache.Queue"
    
    private let queue: DispatchQueue
    private let fileManager: FileManager
    private let path: URL

    public init(
        path: URL,
        queue: DispatchQueue = .init(label: DiskStorage.queueLabel),
        fileManager: FileManager = FileManager.default
    ) {
        self.path = path
        self.queue = queue
        self.fileManager = fileManager
    }
    
    private func createFolders(in url: URL) throws {
        let folderUrl = url.deletingLastPathComponent()
        if !fileManager.fileExists(atPath: folderUrl.path) {
            try fileManager.createDirectory(
                at: folderUrl,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
    }
}

extension DiskStorage: WritableStorage {
    public func save(value: Data, for key: String) throws {
        let url = path.appendingPathComponent(key)
        do {
            try self.createFolders(in: url)
            try value.write(to: url, options: .atomic)
        } catch {
            throw StorageError.cantWrite(error)
        }
    }

    public func save(value: Data, for key: String, handler: @escaping Handler<Data>) {
        queue.async {
            do {
                try self.save(value: value, for: key)
                handler(.success(value))
            } catch {
                handler(.failure(error))
            }
        }
    }
}

extension DiskStorage: ReadableStorage {
    public func fetchValue(for key: String) throws -> Data {
        let url = path.appendingPathComponent(key)
        guard let data = fileManager.contents(atPath: url.path) else {
            throw StorageError.notFound
        }
        return data
    }

    public func fetchValue(for key: String, handler: @escaping Handler<Data>) {
        queue.async {
            handler(Result { try self.fetchValue(for: key) })
        }
    }
}

extension DiskStorage: RemovableStorage {
    public func remove(for key: String) throws {
        let url = path.appendingPathComponent(key)
        guard fileManager.contents(atPath: url.path) != nil else {
            throw StorageError.notFound
        }
        
        try fileManager.removeItem(atPath: url.path)
    }
    
    public func remove(for key: String, handler: @escaping Handler<Bool>) {
        queue.async {
            do {
                try self.remove(for: key)
                handler(.success(true))
            } catch {
                handler(.failure(error))
            }
        }
    }
}
