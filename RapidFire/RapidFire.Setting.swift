//
//  RapidFire.Setting.swift
//  RapidFire
//
//  Created by keygx on 2016/11/19.
//  Copyright © 2016年 keygx. All rights reserved.
//

import Foundation

extension RapidFire {
    
    public enum HTTPMethod: String {
        case get    = "GET"
        case post   = "POST"
        case put    = "PUT"
        case patch  = "PATCH"
        case delete = "DELETE"
    }
    
    public struct PartData {
        public var name:     String
        public var filename: String
        public var value:    Data
        public var mimeType: String
        
        public init(name: String, filename: String, value: Data, mimeType: String) {
            self.name     = name
            self.filename = filename
            self.value    = value
            self.mimeType = mimeType
        }
    }
    
    class RequestSetting {
        var method:            HTTPMethod?
        var baseUrl:           String?
        var path:              String?
        var headers:           [String: String]?
        var query:             [String: String]?
        var bodyParams:        [String: String]?
        var bodyData:          Data?
        var json:              [String: Any]?
        var partDataParams:    [String: String]?
        var partDataBinary:    [PartData]?
        var timeoutInterval:   TimeInterval?
        var retryCount: Int    = 0
        var retryInterval: Int = 15
        var completionHandler: ((RapidFire.Response) -> Void)?
    }
}
