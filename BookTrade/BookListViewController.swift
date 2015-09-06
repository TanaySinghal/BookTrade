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
    var currentIndexPressed:String = "";
    
    var titleList: [String] = [];
    var indexList: [String] = [];
    
    @IBOutlet weak var Text: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "TextCell"
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count;
        //indexList would have same count
    }
    
    //This method displays each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //This is for memory purposes
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        
        cell.textLabel?.text = titleList[row]
        
        return cell
    }
    
    //print out what user taps
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        print("Title is \(titleList[row]) and index is \(indexList[row])")
        
        
        //TODO: Open this book using view book segueway
        currentIndexPressed = indexList[row];
        self.performSegueWithIdentifier("ViewBook", sender: self);
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ViewBook") {
            let theDestination = (segue.destinationViewController as! ViewBookViewController);
            print(currentIndexPressed);
            theDestination.findID = currentIndexPressed;
        }
    }
    

}
