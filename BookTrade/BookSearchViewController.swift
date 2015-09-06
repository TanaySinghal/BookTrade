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
        let searchString = search.text;
        
        //Pass searchString variable to next view
        
        self.performSegueWithIdentifier("SearchBooks", sender: self)
        //print(searchString);
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
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
                            indexList.append(temp);
                        }
                    }
                    
                    let theDestination = (segue.destinationViewController as! BookListViewController);
                    
                    theDestination.indexList = indexList;
                    print("From another place\(theDestination.indexList)")
                    
                    for element in indexList {
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
