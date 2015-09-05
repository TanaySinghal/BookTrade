//
//  RegisterPageViewController.swift
//  BookTrade
//
//  Created by Tanay Singhal on 9/5/15.
//  Copyright (c) 2015 BookTrade. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        let userEmail = userEmailTextField.text!;
        let userName = userNameTextField.text!;
        let userPassword = userPasswordTextField.text!;
        let repeatPassword = repeatPasswordTextField.text!;
        
        //Check for empty fields
        if(userEmail.isEmpty || userName.isEmpty || userPassword.isEmpty || repeatPassword.isEmpty) {
            //Display alert message
            displayAlertMessage("All fields are required");
            return;
        }
        
        //Check if passwords match
        if(userPassword != repeatPassword) {
            //Display alert message
            displayAlertMessage("Passwords do not match");
            return;
        }
        
        //Sending post request
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/BookTrade/Register.php")!)
        request.HTTPMethod = "POST"
        let postString = "email=" + userEmail + "&name=" + userName + "&password=" + userPassword;
        
        print("PostString=\(postString)")
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            //print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print("responseString = \(responseString)")
        }
        task.resume()
        //Store data
        /*NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail");
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName");
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword");
        NSUserDefaults.standardUserDefaults().synchronize();*/
        
        //Display message w/ confirmation
        var myAlert = UIAlertController(title:"Alert", message:"Registration successful", preferredStyle:UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default) {
            action in self.dismissViewControllerAnimated(true, completion:nil)
        }
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion:nil);
        
    }

    func displayAlertMessage(alertMessage:String) {
        let myAlert = UIAlertController(title:"Alert", message:alertMessage, preferredStyle:UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler:nil);
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion:nil);
    }
}
