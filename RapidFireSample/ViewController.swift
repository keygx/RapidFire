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
            print("success:\n \(response.statusCode): \(response.response)")
            print(RapidFire.Util.toDictionary(from: response.data))
        case .failure:
            print("error:\n \(response.statusCode): \(response.error)")
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
            .shoot()
    }
    
    @IBAction func btnPostAction(_ sender: UIButton) {
        // POST with Body Message
        RapidFire(.post, "https://httpbin.org")
            .setPath("/post")
            .setBody(["a":"1", "b":"2"])
            .setCompletionHandler(handler)
            .shoot()
    }
    
    @IBAction func btnPostJsonAction(_ sender: UIButton) {
        // POST with JSON
        RapidFire(.post, "https://httpbin.org")
            .setPath("/post")
            .setJSON(["a":"1", "b":"2"])
            .setCompletionHandler(handler)
            .shoot()
    }
}
