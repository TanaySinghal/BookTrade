//
//  BookSearchViewController.swift
//  BookTrade
//
//  Created by Tanay Singhal on 9/5/15.
//  Copyright © 2015 BookTrade. All rights reserved.
//

import UIKit

class BookSearchViewController: UIViewController {

    
    @IBOutlet weak var search: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("SearchBooks", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "SearchBooks") {
            var titleList: [String] = []
            var indexList: [String] = []
            
            let searchInput = search.text!
            
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
                        
                        
                        for var i = 0; i < json.count; i++ {
                            let temp = json[i]["title"]!
                            if temp.lowercaseString.rangeOfString(searchInput) != nil {
                                //Add row that each thing is on
                                titleList.append(temp);
                                
                                let temp2 = (json[i]["book_id"]);
                                indexList.append(temp2!);
                            }
                        }
                        
                        let theDestination = (segue.destinationViewController as! BookListViewController);
                        
                        theDestination.titleList = titleList;
                        theDestination.indexList = indexList;
                        print("From another place\(theDestination.titleList)")
                        
                        for element in titleList {
                            print("Found: \(element)");
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
}
