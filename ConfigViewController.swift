//
//  ConfigViewController.swift
//  NESController2
//
//  Created by Stef Janssen on 18/10/14.
//  Copyright (c) 2014 Stef Janssen. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {

    @IBOutlet weak var ipadressfield: UITextField!
    
    var ip: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ipadressfield.text = ip
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
