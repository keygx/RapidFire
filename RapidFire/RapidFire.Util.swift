//
//  RapidFire.Util.swift
//  RapidFire
//
//  Created by keygx on 2016/11/19.
//  Copyright © 2016年 keygx. All rights reserved.
//

import Foundation

extension RapidFire {
    
    public class Util {
        
        // Convert JSON to Dictionary
        public static func toDictionary(from data: Data?) -> [String: Any] {
            var dic = [String: Any]()
            
            if let jsonData = data {
                do {
                    dic = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String: Any]
                } catch {
                    print("Converting Failed.")
                }
            }
            
            return dic
        }
        
        // Convert JSON to Array
        public static func toArray(from data: Data?) -> [[String: Any]] {
            var arr = [[String: Any]]()
            
            if let jsonData = data {
                do {
                    arr = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [[String: Any]]
                } catch {
                    print("Converting Failed.")
                }
            }
            
            return arr
        }
        
        // Convert JSON to String
        public static func toString(from data: Data?) -> String {
            if let stringData = data {
                if let string = String(data: stringData, encoding: String.Encoding.utf8) {
                    return string
                }
            }
            
            return ""
        }
        
        // Convert to JSON
        public static func toJSON(from object: Any) -> Data {
            var json = Data()
            
            do {
                json = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            } catch {
                print("JSON Generation failed.")
            }
            
            return json
        }
    }
}
