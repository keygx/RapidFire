//
//  RapidFire.swift
//  RapidFire
//
//  Created by keygx on 2016/11/19.
//  Copyright © 2016年 keygx. All rights reserved.
//

import Foundation

public class RapidFire {
    
    var settings = RapidFire.RequestSetting()
    var task: URLSessionDataTask?
    
    public init() {}
    
    public init(_ method: HTTPMethod, _ baseUrl: String) {
        settings.method = method
        settings.baseUrl = baseUrl
    }
    
    public func setPath(_ path: String) -> Self {
        settings.path = path
        return self
    }
    
    public func setHeaders(_ headers: [String: String]) -> Self {
        settings.headers = headers
        return self
    }
    
    public func setQuery(_ params: [String: String]) -> Self {
        settings.query = params
        return self
    }
    
    public func setBody(_ params: [String: String]) -> Self {
        settings.bodyParams = params
        return self
    }
    
    public func setBody(_ params: Data) -> Self {
        settings.bodyData = params
        return self
    }
    
    public func setJSON(_ json: [String: Any]) -> Self {
        settings.json = json
        return self
    }
    
    public func setPartData(_ params: [String: String]) -> Self {
        settings.partDataParams = params
        return self
    }
    
    public func setPartData(_ data: PartData) -> Self {
        if settings.partDataBinary == nil {
            settings.partDataBinary = [PartData]()
        }
        settings.partDataBinary?.append(data)
        return self
    }
   
    public func setTimeout(_ timeout: TimeInterval) -> Self {
        settings.timeoutInterval = timeout
        return self
    }
    
    public func setRetry(_ count: Int, intervalSec: Int = 10) -> Self {
        settings.retryCount = count
        settings.retryInterval = intervalSec
        return self
    }
    
    public func setCompletionHandler(_ handler: @escaping (RapidFire.Response) -> Void) -> Self {
        settings.completionHandler = handler
        return self
    }

    public func setRequestCachePolicy (_ cachePolicy: NSURLRequest.CachePolicy) -> Self {
        settings.requestCachePolicy = cachePolicy
        return self
    }
    
    public func fire() {
        DispatchQueue.global().async {
            self.start()
        }
    }
}
