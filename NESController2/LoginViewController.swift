//
//  LoginViewController.swift
//  NESController2
//
//  Created by Stef Janssen on 17/10/14.
//  Copyright (c) 2014 Stef Janssen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("loaded login view")
        username?.text = ""
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loginSegue"{
            let vc = segue.destinationViewController as ViewController
            if let name = username?.text? {
                vc.username = name
            } else {
                return
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
