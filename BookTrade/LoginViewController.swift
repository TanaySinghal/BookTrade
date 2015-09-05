//
//  LoginViewController.swift
//  BookTrade
//
//  Created by Tanay Singhal on 9/5/15.
//  Copyright (c) 2015 BookTrade. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        let url = NSURL(string: "http://localhost:8888/BookTrade/Conn.php")
        let request = NSMutableURLRequest(URL: url!)
        
        // modify the request as necessary, if necessary
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if data == nil {
                print("request failed \(error)")
                return
            }
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [[String:String]] {
                    //Look through all email
                    
                    var foundEmail:Bool = false;
                    var password:String = "";
                    
                    for row in json {
                        let email = row["email"];
                        password = row["password"]!;
                        if(userEmail == email) {
                            foundEmail = true;
                            break;
                        }
                    }
                    
                    if foundEmail == true {
                        if(userPassword == password) {
                            //Login is successful
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                            NSUserDefaults.standardUserDefaults().synchronize();
                            self.dismissViewControllerAnimated(true, completion:nil);
                        }
                        else {
                            print("Password not found");
                        }
                    }
                    else {
                        print("Email not found");
                    }
                }
                else {
                    print("parsing error")
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("raw response: \(responseString)")
                }
            }
            catch let error as NSError {
                print("error \(error)")
            }
        }
        task.resume()
        
        
        //Old code
        
        /*let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail");
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword");
        
        //If these emails and passwords match to database
        if(userEmail == userEmailStored) {
            if(userPasswordStored == userPassword) {
                //Login is successful
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                self.dismissViewControllerAnimated(true, completion:nil);
            }
        }*/
        
        
    }
}
