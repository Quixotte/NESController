//
//  ViewController.swift
//  NESController2
//
//  Created by Stef Janssen on 16/10/14.
//  Copyright (c) 2014 Stef Janssen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let url = NSURL(string: "http://www.stackoverflow.com")
    //these indices correspond to the tag values
    enum ButtonTypes: Int {
        case Left = 1, Right, Fire, Jump
    }
    
    var username = "no_username"
    
    @IBOutlet weak var textview: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textview.text = username
        textview.textAlignment = .Center
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressed(sender: AnyObject) {
        
        if let buttonType = ButtonTypes.fromRaw(sender.tag){
            var buttonPressed = "noButtonPressed"
            switch(buttonType)
                {
            case .Left:
                println("Pressed Left")
                var buttonPressed = "pressedLeft"
            case .Right:
                println("Pressed Right")
                var buttonPressed = "pressedRight"
            case .Fire:
                println("Pressed Fire")
                var buttonPressed = "pressedFire"
            case .Jump:
                println("Pressed Jump")
                var buttonPressed = "pressedJump"
            default:
                println("Untagged button pressed")
                var buttonPressed = "unknownButtonPressed"
            }
            var NESparams = ["buttonPressed":buttonPressed, "username":username] as Dictionary<String, String>
            
            let succes = sendHttpPost(url, params: NESparams)
            if (succes == true){
                println("yay")
            }
        }
    }
    
    func sendHttpPost(url: NSURL, params: Dictionary<String, String>) -> Bool{
        var request = NSMutableURLRequest(URL: url)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            //println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    //println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
        return true
    }
}

