//
//  HttpRequestSender.swift
//  NESController2
//
//  Created by Stef Janssen on 18/10/14.
//  Copyright (c) 2014 Stef Janssen. All rights reserved.
//

import Foundation

class HttpRequestSender: NSOperation {

    var url: String
    
    var params: Dictionary<String, String>
    
    init(params: Dictionary<String, String>, url: String) {
        self.params = params
        self.url = url
    }
    
    var available:Bool = true
    
    override func main() -> (){
        post(params, url: url)
    }
    
    func post(params : Dictionary<String, String>, url : String) -> Bool{
        if (available){
            available = false
            var myUrl = url
            myUrl += "?"
            for k in params.keys
            {
                println(k)
                myUrl += k + "=" + params[k]! + "&"
            }
            
            myUrl = myUrl.substringToIndex(myUrl.endIndex.predecessor())
            println(myUrl)
            
            var url = NSURL(string: myUrl)
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
                println(NSString(data: data, encoding: NSUTF8StringEncoding))
            }
            task.resume()
            available = true
            return true
        }
        return false
    }
}
