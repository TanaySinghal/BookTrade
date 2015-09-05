//
//  SellBookViewController.swift
//  BookTrade
//
//  Created by Tanay Singhal on 9/5/15.
//  Copyright © 2015 BookTrade. All rights reserved.
//

import UIKit

class SellBookViewController: UIViewController {

    @IBOutlet weak var bookName: UITextField!
    @IBOutlet weak var bookISBN: UITextField!
    @IBOutlet weak var bookCondition: UITextField!
    @IBOutlet weak var bookPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func listBook(sender: AnyObject) {
        let name = bookName.text;
        let ISBN = bookISBN.text;
        let condition = bookCondition.text;
        let price = bookPrice.text;
        
        print("Name = \(name)");
        print("Condition = \(condition)");
        print("ISBN = \(ISBN)");
        print("Price = \(price)");
        
        if(name!.isEmpty || ISBN!.isEmpty || condition!.isEmpty || price!.isEmpty) {
            displayAlertMessage("Fields cannot be empty");
            return;
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/BookTrade/ListBook.php")!)
        request.HTTPMethod = "POST"
        let postString1 = "seller_id=" + "1" + "&title=" + name!;
        let postString2 = "&author=" + "lol";
        let postString3 = "&cost=" + price! + "&isbn=" + ISBN!;
        let postString4 = "&book_condition=" + condition! + "&zip_code=" + "100";
        let postString = postString1 + postString2 + postString3 + postString4;
        //TODO: Remove dollar sign from price
        //TODO: book_condition doesn't work
        //TODO:
        print("PostString=\(postString)");
        
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
        
        //Notification
        var myAlert = UIAlertController(title:"Book listed", message:"Thank you", preferredStyle:UIAlertControllerStyle.Alert);
        
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
