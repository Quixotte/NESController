//
//  ConfigViewController.swift
//  NESController2
//
//  Created by Stef Janssen on 18/10/14.
//  Copyright (c) 2014 Stef Janssen. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {


    @IBOutlet weak var ipfield: UITextField!
    
    var delegate: ViewController? = nil
    
    var myip: NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("loaded config view")
        if ipfield != nil {
            ipfield.text = myip
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submit(sender: UIButton) {
        if delegate != nil{
            delegate!.myip = ipfield.text
        }
        else {
            println("nopediedoop")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "returnToViewControllerSegue"{
            let vc = segue.destinationViewController as ViewController
            if let ip = ipfield?.text? {
                println("setting ip")
                vc.myip = ip
            } else {
                return
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
