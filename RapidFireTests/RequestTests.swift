//
//  RequestTests.swift
//  RapidFireSample
//
//  Created by keygx on 2016/11/25.
//  Copyright © 2016年 keygx. All rights reserved.
//

import XCTest
@testable import RapidFire

class RequestTests: XCTestCase {
    
    var session = RapidFire()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_createURLRequest_GET() {
        session.settings.baseUrl = "https://example.com"
        session.settings.path = "/get"
        session.settings.query = ["a":"1", "b":"2"]
        session.settings.body = ["a":"2", "b":"3"]
        
        XCTAssertEqual(session.createURLRequest(.get, session.settings.baseUrl!)?.httpMethod, RapidFire.HTTPMethod.get.rawValue)
        XCTAssertEqual(session.createURLRequest(.get, session.settings.baseUrl!)?.url?.absoluteString, "https://example.com/get?b=2&a=1")
    }
    
    func test_createURLRequest_POST() {
        session.settings.baseUrl = "https://example.com"
        session.settings.path = "/post"
        session.settings.query = ["a":"1", "b":"2"]
        session.settings.body = ["a":"2", "b":"3"]
        
        XCTAssertEqual(session.createURLRequest(.post, session.settings.baseUrl!)?.httpMethod, RapidFire.HTTPMethod.post.rawValue)
        XCTAssertEqual(session.createURLRequest(.post, session.settings.baseUrl!)?.url?.absoluteString, "https://example.com/post")
        XCTAssertEqual(session.createURLRequest(.post, session.settings.baseUrl!)?.httpBody, "b=3&a=2".data(using: String.Encoding.utf8))
    }
    
    func test_createURLRequest_PUT() {
        session.settings.baseUrl = "https://example.com"
        session.settings.path = "/put"
        session.settings.query = ["a":"1", "b":"2"]
        session.settings.body = ["a":"2", "b":"3"]
        
        XCTAssertEqual(session.createURLRequest(.put, session.settings.baseUrl!)?.httpMethod, RapidFire.HTTPMethod.put.rawValue)
        XCTAssertEqual(session.createURLRequest(.put, session.settings.baseUrl!)?.url?.absoluteString, "https://example.com/put")
        XCTAssertEqual(session.createURLRequest(.put, session.settings.baseUrl!)?.httpBody, "b=3&a=2".data(using: String.Encoding.utf8))
    }
    
    func test_createURLRequest_PATCH() {
        session.settings.baseUrl = "https://example.com"
        session.settings.path = "/patch"
        session.settings.query = ["a":"1", "b":"2"]
        session.settings.body = ["a":"2", "b":"3"]
        
        XCTAssertEqual(session.createURLRequest(.patch, session.settings.baseUrl!)?.httpMethod, RapidFire.HTTPMethod.patch.rawValue)
        XCTAssertEqual(session.createURLRequest(.patch, session.settings.baseUrl!)?.url?.absoluteString, "https://example.com/patch")
        XCTAssertEqual(session.createURLRequest(.patch, session.settings.baseUrl!)?.httpBody, "b=3&a=2".data(using: String.Encoding.utf8))
    }
    
    func test_createURLRequest_DELETE_Query() {
        session.settings.baseUrl = "https://example.com"
        session.settings.path = "/delete"
        session.settings.query = ["a":"1", "b":"2"]
        
        XCTAssertEqual(session.createURLRequest(.delete, session.settings.baseUrl!)?.httpMethod, RapidFire.HTTPMethod.delete.rawValue)
        XCTAssertEqual(session.createURLRequest(.delete, session.settings.baseUrl!)?.url?.absoluteString, "https://example.com/delete?b=2&a=1")
    }
    
    func test_createURLRequest_DELETE_Body() {
        session.settings.baseUrl = "https://example.com"
        session.settings.path = "/delete"
        session.settings.body = ["a":"2", "b":"3"]
        
        XCTAssertEqual(session.createURLRequest(.delete, session.settings.baseUrl!)?.httpMethod, RapidFire.HTTPMethod.delete.rawValue)
        XCTAssertEqual(session.createURLRequest(.delete, session.settings.baseUrl!)?.url?.absoluteString, "https://example.com/delete")
        XCTAssertEqual(session.createURLRequest(.delete, session.settings.baseUrl!)?.httpBody, "b=3&a=2".data(using: String.Encoding.utf8))
    }
    
    func test_createURLRequest_Multipart() {
        session.settings.baseUrl = "https://example.com/multipart"
        session.settings.partDataParams = ["a":"1", "b":"2"]
        let filePath = Bundle(for: type(of: self)).path(forResource: "circle", ofType: "png")
        let imageData = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        session.settings.partDataBinary?.append(RapidFire.PartData(name: "image", filename: "circle.png", value: imageData, mimeType: "image/png"))
        let request = session.createURLRequest(.post, session.settings.baseUrl!)
        
        XCTAssertEqual(request?.httpMethod, RapidFire.HTTPMethod.post.rawValue)
        XCTAssertEqual(request?.url?.absoluteString, "https://example.com/multipart")
        XCTAssertEqual(request?.httpBody, session.buildMultipartFormData(request: request!, params: session.settings.partDataParams, partData: session.settings.partDataBinary) as Data)
    }
    
    func test_createURLRequest_TimeoutInterval() {
        session.settings.baseUrl = "https://example.com"
        session.settings.path = "/get"
        session.settings.timeoutInterval = 15
        
        XCTAssertEqual(session.createURLRequest(.get, session.settings.baseUrl!)?.timeoutInterval, 15)
    }
    
    func test_addHeaders() {
        let headers = ["Content-Type":"image/jpeg", "MyCustom":"value"]
        session.settings.headers = headers
        let request = NSMutableURLRequest(url: URL(string: "https://example.com")!)
        session.addHeaders(request: request)
        
        XCTAssertEqual(request.allHTTPHeaderFields?.count, 2)
        XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "image/jpeg")
        XCTAssertEqual(request.allHTTPHeaderFields?["MyCustom"], "value")
    }
    
    func test_buildQueryParameters() {
        let params = ["b":"2", "a":"1"]
        session.settings.method = .get
        
        XCTAssertEqual(session.buildQueryParameters(parameters: params), "b=2&a=1")
        XCTAssertNil(session.buildQueryParameters(parameters: nil))
    }
    
    func test_buildBodyParameters() {
        let params = ["b":"2", "a":"1"]
        session.settings.method = .post
        
        XCTAssertEqual(session.buildBodyParameters(parameters: params), "b=2&a=1")
        XCTAssertNil(session.buildBodyParameters(parameters: nil))
    }
}
