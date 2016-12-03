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

extension RapidFire.Response {
    
    // Convert JSON to Dictionary
    public func toDictionary() -> [String: Any] {
        var dic = [String: Any]()
        
        if let jsonData = self.data {
            do {
                dic = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String: Any]
            } catch {
                print("Converting Failed.")
            }
        }
        
        return dic
    }
    
    // Convert JSON to Array
    public func toArray() -> [[String: Any]] {
        var arr = [[String: Any]]()
        
        if let jsonData = self.data {
            do {
                arr = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [[String: Any]]
            } catch {
                print("Converting Failed.")
            }
        }
        
        return arr
    }
    
    // Convert JSON to String
    public func toString() -> String {
        if let stringData = self.data {
            if let string = String(data: stringData, encoding: String.Encoding.utf8) {
                return string
            }
        }
        
        return ""
    }
}
