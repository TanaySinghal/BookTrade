//
//  ProfileViewController.swift
//  BookTrade
//
//  Created by Tanay Singhal on 9/6/15.
//  Copyright © 2015 BookTrade. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var ProfileTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = NSUserDefaults.standardUserDefaults().valueForKey("userName");
        print("user name is \(userName)");
        if(userName != nil) {
            ProfileTitle.title = userName as? String;
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TODO: Update values

}
