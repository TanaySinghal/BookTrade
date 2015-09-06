//
//  BookListViewController.swift
//  BookTrade
//
//  Created by Tanay Singhal on 9/5/15.
//  Copyright © 2015 BookTrade. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {

    var searchInput:String = "";
    
    @IBOutlet weak var Text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Search input \(searchInput)");
        Text.text = searchInput;
        
        // Look through all book titles and store the ones that contain text
        
        //First just list all books/TODO: get rest of info from book ID
        
        let url = NSURL(string: "http://localhost:8888/BookTrade/Books.php")
        let request = NSMutableURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if data == nil {
                print("request failed \(error)")
                return
            }
            
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [[String:String]] {
                    
                    var indexList: [Int] = []
                    
                   
                    for var i = 0; i < json.count; i++ {
                        let temp = json[i]["title"]!
                        if temp.lowercaseString.rangeOfString(self.searchInput) != nil {
                            indexList.append(i);
                        }
                    }
                    
                    for element in indexList {
                        let temp = json[element]["title"]!
                        print("Found: \(temp)");
                    }
                    
                    /*dispatch_async(dispatch_get_main_queue()) {
                        self.bookName.text = title;
                        self.bookAuthor.text = author;
                        self.bookISBN.text = isbn;
                        self.bookCondition.text = condition;
                        self.bookPrice.text = cost;
                        self.bookSeller.text = seller_id;
                        self.bookZipCode.text = zipCode;
                    }*/
                    
                    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
