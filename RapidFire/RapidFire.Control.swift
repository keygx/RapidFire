//
//  RapidFire.Control.swift
//  RapidFire
//
//  Created by keygx on 2016/11/19.
//  Copyright © 2016年 keygx. All rights reserved.
//

import Foundation

extension RapidFire {
    
    // Session Start
    func start() {
        
        guard let method = settings.method, let baseUrl = settings.baseUrl else {
            // Item shortage
            return
        }
        
        guard let request = createURLRequest(method, baseUrl) else {
            // URLRequest creation failure
            return
        }
        
        // CompletionHandler
        let completionHandler: ((Data?, URLResponse?, Error?) -> Void) = { (data, response, error) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            if error != nil {
                self.failure(statusCode, data, response, error)
            } else {
                self.success(statusCode, data, response, error)
            }
        }
        
        // URLSessionConfig
        let config = URLSessionConfiguration.default
        // URLSession
        let session = URLSession(configuration: config)
        
        // URLSessionDataTask
        task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
        
        resume()
    }
    
    // Task Resume
    public func resume() {
        if let task = task {
            task.resume()
        }
    }
    
    // Task Suspend
    public func suspend() {
        if let task = task {
            task.suspend()
        }
    }
    
    // Task Cancel
    public func cancel() {
        if let task = task {
            task.cancel()
        }
    }
}

extension RapidFire {
    
    func failure(_ statusCode: Int?, _ data: Data?, _ response: URLResponse?, _ error: Error?) {
        if settings.retryCount > 0 {
            print("\(settings.retryCount) time remaining")
            settings.retryCount -= 1
            
            let dispatchTime: DispatchTime = DispatchTime.now() + DispatchTimeInterval.seconds(settings.retryInterval)
            DispatchQueue.global().asyncAfter(deadline: dispatchTime) {
                self.start()
            }
        } else {
            callback(RapidFire.Response(result: .failure, statusCode: statusCode, data: data, response: response, error: error))
        }
    }
    
    func success(_ statusCode: Int?, _ data: Data?, _ response: URLResponse?, _ error: Error?) {
        callback(RapidFire.Response(result: .success, statusCode: statusCode, data: data, response: response, error: error))
    }
    
    func callback(_ response: RapidFire.Response) {
        guard let handler = settings.completionHandler else {
            return
        }
        
        handler(response)
    }
}
