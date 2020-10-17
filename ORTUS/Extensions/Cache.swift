//
//  Cache.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 5/7/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

class Cache {
    static let temporaryDirectory = URL(fileURLWithPath: NSTemporaryDirectory())
    
    let path: URL
    
    let disk: DiskStorage
    
    let storage: CodableStorage
    
    static let shared = Cache()
    
    init(
        path: URL? = nil,
        disk: DiskStorage? = nil,
        storage: CodableStorage? = nil
    ) {
        let storagePath = path ?? Self.temporaryDirectory
        self.path = storagePath
        let diskStorage = disk ?? DiskStorage(path: storagePath)
        self.disk = diskStorage
        self.storage = storage ?? CodableStorage(storage: diskStorage)
    }
    
    func save<Object: Any>(_ object: Object, forKey key: String) where Object: Codable {
        try? storage.save(object, for: key)
    }
    
    func fetch<Object: Any>(
        _ type: Object.Type,
        forKey key: String
    ) throws -> Object where Object: Codable {
        do {
            let object: Object = try storage.fetch(for: key)
            
            return object
        } catch {
            throw error
        }
    }
    
    func clear() {
        let temporaryDirectory = try? FileManager.default.contentsOfDirectory(atPath: path.path)
        
        temporaryDirectory?.forEach { file in
            let fileUrl = Self.temporaryDirectory.appendingPathComponent(file)
            try? FileManager.default.removeItem(at: fileUrl)
        }
    }
}
