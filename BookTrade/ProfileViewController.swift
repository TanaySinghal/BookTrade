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
    
    @IBOutlet weak var money: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //These have been set in login view controller
        let userName = NSUserDefaults.standardUserDefaults().valueForKey("userName");
        let moneyFormat = "Money: $";
        let moneyValue = NSUserDefaults.standardUserDefaults().valueForKey("currentMoney") as! String;

        money.text = moneyFormat + moneyValue;
        
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
