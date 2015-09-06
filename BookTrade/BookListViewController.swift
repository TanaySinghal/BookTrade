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
    var indexList: [String] = [];
    
    @IBOutlet weak var Text: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "TextCell"
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Hello \(indexList)")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Look through all book titles and store the ones that contain text
        
        //First just list all books/TODO: get rest of info from book ID
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        
        //Get
        
        cell.textLabel?.text = indexList[row]
        //indexList[row] as? String
        
//        print(indexList[row])
        
        return cell
    }
    
    //print out what user taps
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        print(indexList[row])
    }

    

}
