//
//  RapidFire.MultipartFormData.swift
//  RapidFire
//
//  Created by keygx on 2016/11/19.
//  Copyright © 2016年 keygx. All rights reserved.
//

import Foundation

extension RapidFire {
    
    func boundary() -> String {
        #if TEST
        return "RapidFire-boundary-TEST"
        #else
        return String(format: "RapidFire-boundary-%08x-%08x", arc4random(), arc4random())
        #endif
    }
    
    func buildMultipartFormData(request: URLRequest, params: [String: String]?, partData: [PartData]?) -> Data {
        
        let boundaryString = boundary()
        var body = Data()
        var formData = ""
        var request = request
        
        request.setValue("multipart/form-data; charset=utf-8; boundary=\(boundaryString)", forHTTPHeaderField: "Content-Type")
        
        // Params
        if let params = params {
            params.forEach { (key: String, value: String) in
                formData = "\r\n"
                formData += "--\(boundaryString)"
                formData += "\r\n"
                formData += "Content-Disposition: form-data; name=\"\(key)\""
                formData += "\r\n\r\n"
                formData += "\(value)"
                formData += "\r\n"
                body.append(formData.data(using: String.Encoding.utf8)!)
            }
        }
        
        // Data
        if let partData = partData {
            partData.forEach { (data: PartData) in
                formData = "\r\n"
                formData += "--\(boundaryString)"
                formData += "\r\n"
                formData += "Content-Disposition: form-data; name=\"\(data.name)\"; filename=\"\(data.filename)\""
                formData += "\r\n"
                formData += "Content-Type: \(data.mimeType)"
                formData += "\r\n\r\n"
                body.append(formData.data(using: String.Encoding.utf8)!)
                body.append(data.value)
                formData = "\r\n"
                body.append(formData.data(using: String.Encoding.utf8)!)
            }
        }
        
        // End boundary
        formData = "--\(boundaryString)"
        formData += "--\r\n\r\n"
        body.append(formData.data(using: String.Encoding.utf8)!)
        
        // Content-Length
        request.setValue(String(describing: body.count), forHTTPHeaderField: "Content-Length")
        
        return body
    }
}
