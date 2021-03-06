//
//  ViewController.swift
//  RapidFireSample
//
//  Created by keygx on 2016/11/19.
//  Copyright © 2016年 keygx. All rights reserved.
//

import UIKit
import RapidFire

class ViewController: UIViewController {
    
    // CompletionHandler
    let handler = { (response: RapidFire.Response) in
        switch response.result {
        case .success:
            print("success:\n \(response.statusCode as Any): \(response.response as Any)")
            print(response.toDictionary())
        case .failure:
            print("error:\n \(response.statusCode as Any): \(response.error as Any)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnGetAction(_ sender: UIButton) {
        // GET with Query Parameters
        RapidFire(.get, "https://httpbin.org")
            .setPath("/get")
            .setQuery(["a":"1", "b":"2"])
            .setCompletionHandler(handler)
            .fire()
    }
    
    @IBAction func btnPostAction(_ sender: UIButton) {
        // POST with Body Message
        RapidFire(.post, "https://httpbin.org")
            .setPath("/post")
            .setBody(["a":"1", "b":"2"])
            .setCompletionHandler(handler)
            .fire()
    }
    
    @IBAction func btnPostJsonAction(_ sender: UIButton) {
        // POST with JSON
        RapidFire(.post, "https://httpbin.org")
            .setPath("/post")
            .setJSON(["a":"1", "b":"2"])
            .setCompletionHandler(handler)
            .fire()
    }
}
