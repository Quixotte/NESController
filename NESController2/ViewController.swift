//
//  ViewController.swift
//  NESController2
//
//  Created by Stef Janssen on 16/10/14.
//  Copyright (c) 2014 Stef Janssen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let prefix = "http://"
    let ip = "192.168.2.25:8001"
    let serveradress = "/marioserver"
    
    let host = "192.168.2.25:8001"
    
    let queue = NSOperationQueue()
    
    let testImage = UIImage(named: "background_nes.jpg")
    let leftImage = UIImage(named: "left_d_pad.png")
    let leftImageHighlighted = UIImage(named: "left_d_pad_pressed.png")
    //these indices correspond to the tag values
    enum ButtonTypes: Int {
        case Left = 1, Right, Fire, Jump
    }
    
    var username = "no_username"
    
    @IBOutlet weak var textview: UITextView!
    
    var pressedLeft = true;
    var pressedRight = false;
    var pressedFire = false;
    var pressedJump = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textview.text = username
        textview.textAlignment = .Center

        // Do any additional setup after loading the view, typically from a nib.
        //var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }


    func update() {
        
        var command: String = ""
        if pressedRight{
            command = command + "right"
        }
        else if pressedLeft{
            command = command + "left"
        }
        if pressedJump {
            command = command + "jump"
        }
        if pressedFire {
            command = command + "fire"
        }
        if (queue.operationCount == 0)
        {
            var NESparams = ["option":"pressButtons",  "command":command, "name":username] as Dictionary<String, String>
            let myurl = prefix + ip + serveradress
            let requestSender = HttpRequestSender(params: NESparams, url: myurl)
            queue.addOperation(requestSender)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "configSegue"{
            let vc = segue.destinationViewController as ConfigViewController
            vc.ip = ip
            
        }
        else {
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchDown(sender: AnyObject) {
        if let buttonType = ButtonTypes.fromRaw(sender.tag){
            switch(buttonType)
                {
            case .Left:
                println("Pressed Left")
                pressedLeft = true;
            case .Right:
                println("Pressed Right")
                pressedRight = true;
            case .Fire:
                println("Pressed Fire")
                pressedFire = true;
            case .Jump:
                println("Pressed Jump")
                pressedJump = true;
            default:
                println("Untagged button pressed")
            }
        }

    }
    
    @IBAction func touchUpOutside(sender: AnyObject) {
        touchUp(sender)
    }
    @IBAction func touchUpInside(sender: AnyObject) {
        touchUp(sender)
    }
    
    func touchUp(sender: AnyObject)
    {
        if let buttonType = ButtonTypes.fromRaw(sender.tag){
            switch(buttonType)
                {
            case .Left:
                println("Released Left")
                pressedLeft = false;
            case .Right:
                println("Released Right")
                pressedRight = false;
            case .Fire:
                println("Released Fire")
                pressedFire = false;
            case .Jump:
                println("Released Jump")
                pressedJump = false;
            default:
                println("Released untagged butto ")
            }
        }
    }
}

