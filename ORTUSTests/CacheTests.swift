//
//  CacheTests.swift
//  ORTUSTests
//
//  Created by Firdavs Khaydarov on 5/14/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import XCTest
@testable import ORTUS

struct CacheTestsModel: Codable {
    let id: Int
    let value: String
}

struct OtherCacheTestsModel: Codable {
    let key: String
    let value: String
}

class CacheTests: XCTestCase {
    var cache: Cache!
    
    static let key = "testKey"
    static let otherKey = "otherTestKey"
    
    override func setUp() {
        super.setUp()
        
        cache = Cache()
    }
    
    func testSaveAndFetch() {
        let model = CacheTestsModel(id: 0, value: "test")
        cache.save(model, forKey: Self.key)
        XCTAssertNoThrow(try cache.fetch(CacheTestsModel.self, forKey: Self.key))
    }
    
    func testSaveOverriding() {
        let model = CacheTestsModel(id: 0, value: "test")
        let lastModel = CacheTestsModel(id: 1, value: "test1")
        cache.save(model, forKey: Self.key)
        cache.save(lastModel, forKey: Self.key)
        XCTAssertEqual(try? cache.fetch(CacheTestsModel.self, forKey: Self.key).id, 1)
    }
    
    func testNotSavedFetch() {
        XCTAssertThrowsError(try cache.fetch(CacheTestsModel.self, forKey: Self.otherKey))
    }
    
    func testFetchOtherType() {
        let model = CacheTestsModel(id: 0, value: "test")
        cache.save(model, forKey: Self.key)
        XCTAssertThrowsError(try cache.fetch(OtherCacheTestsModel.self, forKey: Self.key))
    }
    
    func testRemove() {
        let model = CacheTestsModel(id: 0, value: "test")
        cache.save(model, forKey: Self.key)
        XCTAssertNoThrow(try cache.remove(forKey: Self.key))
        XCTAssertThrowsError(try cache.fetch(CacheTestsModel.self, forKey: Self.key))
    }
}
