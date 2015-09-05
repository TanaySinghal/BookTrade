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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: get rest of info from book ID
        let bookID = "1";
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/BuyBook.php")!)
        request.HTTPMethod = "GET"
        
        let postString = "book_id=" + bookID;
        print("PostString=\(postString)")
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [[String:String]] {
                    
                    print("json: \(json)");
                    
                    let seller_id = json[0]["seller_id"];
                    let title = json[0]["title"];
                    let author = json[0]["author"];
                    let cost = json[0]["cost"];
                    let isbn = json[0]["isbn"];
                    let condition = json[0]["book_condition"];
                    let zipCode = json[0]["zip_code"];
                    
                    print(seller_id);
                    print(title);
                    print(author);
                    print(cost);
                    print(isbn);
                    print(condition);
                    print(zipCode);
                    
                    self.bookName.text = title;
                    self.bookAuthor.text = author;
                    self.bookISBN.text = isbn;
                    self.bookCondition.text = condition;
                    self.bookPrice.text = cost;
                    self.bookSeller.text = seller_id;
                    self.bookZipCode.text = zipCode;
                    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
