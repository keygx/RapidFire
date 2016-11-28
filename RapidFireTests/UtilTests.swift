//
//  UtilTests.swift
//  RapidFireTests
//
//  Created by keygx on 2016/11/19.
//  Copyright © 2016年 keygx. All rights reserved.
//

import XCTest
@testable import RapidFire

class UtilTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_toJsonDictionary() {
        let json: [String: Any] = ["a":1, "b":"あ"]
        let testData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        XCTAssertEqual(RapidFire.Util.toDictionary(from: testData)["a"] as? Int, 1)
        XCTAssertEqual(RapidFire.Util.toDictionary(from: testData)["b"] as? String, "あ")
        XCTAssertEqual(RapidFire.Util.toDictionary(from: nil).count, 0)
        XCTAssertNotEqual(RapidFire.Util.toDictionary(from: testData)["a"] as? Int, 1000)
        XCTAssertNotEqual(RapidFire.Util.toDictionary(from: testData)["b"] as? String, "ん")
    }
    
    func test_toJsonArray() {
        let json: [[String: Any]] = [["a":1, "b":"あ"], ["a":1000, "b":"い"]]
        let testData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        XCTAssertEqual(RapidFire.Util.toArray(from: testData)[0]["a"] as? Int, 1)
        XCTAssertEqual(RapidFire.Util.toArray(from: testData)[0]["b"] as? String, "あ")
        XCTAssertEqual(RapidFire.Util.toArray(from: testData)[1]["a"] as? Int, 1000)
        XCTAssertEqual(RapidFire.Util.toArray(from: testData)[1]["b"] as? String, "い")
        XCTAssertEqual(RapidFire.Util.toArray(from: nil).count, 0)
        XCTAssertNotEqual(RapidFire.Util.toArray(from: testData)[0]["a"] as? Int, 1000)
        XCTAssertNotEqual(RapidFire.Util.toArray(from: testData)[0]["b"] as? String, "ん")
    }
    
    func test_toString() {
        let str = "RapidFire"
        let testData = str.data(using: String.Encoding.utf8)
        
        XCTAssertEqual(RapidFire.Util.toString(from: testData), str)
        XCTAssertEqual(RapidFire.Util.toString(from: nil), "")
        XCTAssertNotEqual(RapidFire.Util.toString(from: testData), "foo bar")
    }
    
    func test_toJSON() {
        let testData: [[String: Any]] = [["a":1, "b":"あ"], ["a":1000, "b":"い"]]
        let json = try! JSONSerialization.data(withJSONObject: testData, options: .prettyPrinted)
        
        XCTAssertEqual(RapidFire.Util.toJSON(from: testData), json)
    }
}
