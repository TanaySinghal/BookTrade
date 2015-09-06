//
//  BookListViewController.swift
//  BookTrade
//
//  Created by Tanay Singhal on 9/5/15.
//  Copyright © 2015 BookTrade. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var searchInput:String = "";
    
    @IBOutlet weak var Text: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "TextCell"
    
    var indexList: [Int] = []
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
                        if temp.lowercaseString.rangeOfString(self.searchInput) != nil {
                            self.indexList.append(i);
                        }
                    }
                    
                    for element in self.indexList {
                        let temp = json[element]["title"]!
                        print("Found: \(temp)");
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
        return indexList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = indexList[row] as? String
        
        return cell
    }
    
    //print out what user taps
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        print(indexList[row])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Search input \(searchInput)");
        Text.text = searchInput;
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Look through all book titles and store the ones that contain text
        
        //First just list all books/TODO: get rest of info from book ID
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
