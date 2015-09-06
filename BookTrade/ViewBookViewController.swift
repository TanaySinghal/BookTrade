//
//  ViewBookViewController.swift
//  BookTrade
//
//  Created by Tanay Singhal on 9/5/15.
//  Copyright © 2015 BookTrade. All rights reserved.
//

import UIKit

class ViewBookViewController: UIViewController {

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookISBN: UILabel!
    @IBOutlet weak var bookCondition: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    @IBOutlet weak var bookSeller: UILabel!
    @IBOutlet weak var bookZipCode: UILabel!
    
    var currentMoney:Double = 0;
    var costOfBook:String = "100";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let findID = "1";
        var foundIDAtRow:Int = 0;
        
        let url = NSURL(string: "http://localhost:8888/BookTrade/Books.php")
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
                    
                    
                    for var i = 0; i < json.count; i++ {
                        if json[i]["book_id"] == findID {
                            foundIDAtRow = i;
                            break;
                        }
                    }
                    
                    print("Checkpoint 1");

                    let seller_id = json[foundIDAtRow]["seller_id"];
                    let title = json[foundIDAtRow]["title"];
                    let author = json[foundIDAtRow]["author"];
                    self.costOfBook = json[foundIDAtRow]["cost"]!;
                    let isbn = json[foundIDAtRow]["isbn"];
                    let condition = json[foundIDAtRow]["book_condition"];
                    let zipCode = json[foundIDAtRow]["zip_code"];
                    
                    print("Checkpoint 2");
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.bookName.text = title;
                        self.bookAuthor.text = author;
                        self.bookISBN.text = isbn;
                        self.bookCondition.text = condition;
                        self.bookPrice.text = self.costOfBook;
                        self.bookSeller.text = seller_id;
                        self.bookZipCode.text = zipCode;
                    }
                    
                    print("Checkpoint 3");
                    
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //TODO: Connect this function to button
    func buyButtonPressed() {
        //Keep track of current user
        //If current user presses button, deduct money and update database
        //Sending post request
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/BookTrade/BuyBook.php")!)
        request.HTTPMethod = "POST"
        
        let moneyTaken = NSNumberFormatter().numberFromString(costOfBook)!.doubleValue
        
        //Need to get current money and user_id (store in login session or something like that?)
        let currentMoney = 10.0
        let user_id = "1"
        
        
        let remainingDollars = "\(currentMoney - moneyTaken)";
        
        //Sending post request
        let postString = "dollar=" + remainingDollars + "&user_id=" + user_id;
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
    }
    
    func getCurrentMoney() {
        //TODO: Get current money
    }

}
