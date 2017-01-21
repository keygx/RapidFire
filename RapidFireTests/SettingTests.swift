//
//  SettingTests.swift
//  RapidFireSample
//
//  Created by keygx on 2016/11/25.
//  Copyright © 2016年 keygx. All rights reserved.
//

import XCTest
@testable import RapidFire

class SettingTests: XCTestCase {
    
    var session = RapidFire()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Setting() {
        let method = RapidFire.HTTPMethod.get
        let baseUrl = "https://example.com"
        let path = "/get"
        let headers = ["MyHeader":"MyHeader"]
        let query = ["a":"1", "b":"2"]
        let body = ["c":"3", "d":"4"]
        let json = ["a":"1", "b":"2", "c":"3", "d":"4"]
        let partDataParams = ["e":"5", "f":"6"]
        let filePath = Bundle(for: type(of: self)).path(forResource: "circle", ofType: "png")
        let imageData = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        let partDataBinary = RapidFire.PartData(name: "image", filename: "circle.png", value: imageData, mimeType: "image/png")
        
        session = RapidFire(method, baseUrl)
        session
            .setPath(path)
            .setHeaders(headers)
            .setQuery(query)
            .setBody(body)
            .setJSON(json)
            .setPartData(partDataParams)
            .setPartData(partDataBinary)
            .setTimeout(15)
            .setRetry(3, intervalSec: 30)
            .setCompletionHandler({ (response: RapidFire.Response) in })
            .fire()
        
        XCTAssertEqual(session.settings.method, method)
        XCTAssertEqual(session.settings.baseUrl, baseUrl)
        XCTAssertEqual(session.settings.path, path)
        XCTAssertEqual(session.settings.headers!, headers)
        XCTAssertEqual(session.settings.query!, query)
        XCTAssertEqual(session.settings.bodyParams!, body)
        XCTAssertEqual(session.settings.json?["a"] as! String, "1")
        XCTAssertEqual(session.settings.json?["b"] as! String, "2")
        XCTAssertEqual(session.settings.json?["c"] as! String, "3")
        XCTAssertEqual(session.settings.json?["d"] as! String, "4")
        XCTAssertEqual(session.settings.partDataParams?["e"], "5")
        XCTAssertEqual(session.settings.partDataParams?["f"], "6")
        XCTAssertEqual(session.settings.partDataBinary?.first?.name, "image")
        XCTAssertEqual(session.settings.partDataBinary?.first?.filename, "circle.png")
        XCTAssertEqual(session.settings.partDataBinary?.first?.value, imageData)
        XCTAssertEqual(session.settings.partDataBinary?.first?.mimeType, "image/png")
        XCTAssertEqual(session.settings.timeoutInterval, 15)
        XCTAssertEqual(session.settings.retryCount, 3)
        XCTAssertEqual(session.settings.retryInterval, 30)
        XCTAssertNotNil(session.settings.completionHandler)
    }
}
