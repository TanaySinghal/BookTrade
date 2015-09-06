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
                    var user_id:String = "";
                    var currentMoney:String = "";
                    var name:String = "";
                    
                    for row in json {
                        let email = row["email"];
                        password = row["password"]!;
                        user_id = row["user_id"]!;
                        currentMoney = row["dollar"]!;
                        if(userEmail == email) {
                            foundEmail = true;
                            name = row["name"]!;
                            break;
                        }
                    }
                    
                    if foundEmail == true {
                        if(userPassword == password) {
                            print("Log in successful!");
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                            NSUserDefaults.standardUserDefaults().setValue(user_id, forKey: "user_id");
                            NSUserDefaults.standardUserDefaults().setValue(name, forKey: "userName");
                            NSUserDefaults.standardUserDefaults().setValue(currentMoney, forKey: "currentMoney");
                            NSUserDefaults.standardUserDefaults().synchronize();
                            
                            //This is how to access...
                            //NSUserDefaults.standardUserDefaults().valueForKey("userName");
                            
                            //Having errors with this...
                            dispatch_sync(dispatch_get_main_queue()) {
                                // place code for main thread here
                                self.performSegueWithIdentifier("PostLogin", sender: self);
                            }
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
        
        
    }
}
