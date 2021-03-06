//
//  RapidFire.Request.swift
//  RapidFire
//
//  Created by keygx on 2016/11/19.
//  Copyright © 2016年 keygx. All rights reserved.
//

import Foundation

extension RapidFire {
    
    // Create URLRequest
    func createURLRequest(_ method: HTTPMethod, _ baseUrl: String) -> URLRequest? {
                
        var request: URLRequest?
        
        switch method {
        case .get:
            request = requestWithQuery(baseUrl)
        case .post, .put, .patch:
            request = requestWithBody(baseUrl)
        case .delete:
            if settings.query != nil {
                request = requestWithQuery(baseUrl)
            } else {
                request = requestWithBody(baseUrl)
            }
        }
        
        guard var validRequest = request else { return nil }
        
        // Method
        validRequest.httpMethod = method.rawValue
        
        // Timeout
        if let timeout = settings.timeoutInterval {
            validRequest.timeoutInterval = timeout
        }
        
        // Headers
        validRequest = addHeaders(request: validRequest)
        
        return validRequest
    }
    
    // QueryString
    func requestWithQuery(_ baseUrl: String) -> URLRequest? {
        // endpoint = baseUrl + path
        var endpoint = baseUrl + (settings.path ?? "")
        
        // Add query
        if let queryString = buildQueryParameters(parameters: settings.query) {
            endpoint = endpoint + "?" + queryString
        }
        
        guard let url = URL(string: endpoint) else {
            // URL creation failure
            return nil
        }
        
        // URLRequest
        let request = URLRequest(url: url)
        
        return request
    }
    
    // BodyMessage
    func requestWithBody(_ baseUrl: String) -> URLRequest? {
        // endpoint = baseUrl + path
        let endpoint = baseUrl + (settings.path ?? "")
        
        guard let url = URL(string: endpoint) else {
            // URL creation failure
            return nil
        }
        
        // URLRequest
        var request = URLRequest(url: url)
        
        // multipart-formdata
        if settings.partDataParams != nil || settings.partDataBinary != nil {
            let body = buildMultipartFormData(request: request, params: settings.partDataParams, partData: settings.partDataBinary)
            request.httpBody = body as Data
            
            return request
        }
        
        // add Body
        if let json = settings.json {
            // add Content-Type application/json
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            do {
                // JSON
                request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                return request
            } catch {
                return nil
            }
        } else if let data = settings.bodyData {
            // Data
            request.httpBody = data
        } else if let paramString = buildBodyParameters(parameters: settings.bodyParams) {
            // Parameters
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        
        return request
    }
    
    // Add Headers
    func addHeaders(request: URLRequest) -> URLRequest {
        
        guard let headers = settings.headers else {
            return request
        }
        
        var request = request
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    // Build Query Parameters
    func buildQueryParameters(parameters: [String: String]?) -> String? {
        
        guard let params = parameters else {
            return nil
        }
        
        var queries: [String] = []
        
        for (key, value) in params {
            if let encoded = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                queries.append(key + "=" + encoded)
            }
        }
        
        return queries.joined(separator: "&")
    }
    
    // Build Body Parameters
    func buildBodyParameters(parameters: [String: String]?) -> String? {
        
        guard let params = parameters else {
            return nil
        }
        
        var queries: [String] = []
        
        for (key, value) in params {
            queries.append(key + "=" + value)
        }
        
        return queries.joined(separator: "&")
    }
}
