//
//  ViewController.swift
//  NESController2
//
//  Created by Stef Janssen on 16/10/14.
//  Copyright (c) 2014 Stef Janssen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myurl = "http://192.168.2.25:8001/marioserver"
    
    let queue = NSOperationQueue()
    
    let testImage = UIImage(named: "background_nes.jpg")
    
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
        let imageView = UIImageView(image: testImage)
        self.view.addSubview(imageView)
        
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
                buttonPressed = "left"
            case .Right:
                println("Pressed Right")
                buttonPressed = "right"
            case .Fire:
                println("Pressed Fire")
                buttonPressed = "fire"
            case .Jump:
                println("Pressed Jump")
                buttonPressed = "jump"
            default:
                println("Untagged button pressed")
                buttonPressed = "unknownButtonPressed"
            }
            var NESparams = ["option":"pressButtons",  "command":buttonPressed, "name":username] as Dictionary<String, String>
            
            if (queue.operationCount == 0)
            {
                let requestSender = HttpRequestSender(params: NESparams, url: myurl)
                queue.addOperation(requestSender)
            }
        }
    }
}

