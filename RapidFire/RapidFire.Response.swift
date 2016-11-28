//
//  RapidFire.Response.swift
//  RapidFire
//
//  Created by keygx on 2016/11/19.
//  Copyright © 2016年 keygx. All rights reserved.
//

import Foundation

extension RapidFire {
    
    // Response Data
    public struct Response {
        
        public enum Result {
            case success
            case failure
        }
        
        public var result:     Result
        public var statusCode: Int?
        public var data:       Data?
        public var response:   URLResponse?
        public var error:      Error?
        
        public init(result: Result, statusCode: Int?, data: Data?, response: URLResponse?, error: Error?) {
            self.result     = result
            self.statusCode = statusCode
            self.data       = data
            self.response   = response
            self.error      = error
        }
    }
}
