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
        print(searchString);
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let theDestination = (segue.destinationViewController as! BookListViewController);
        theDestination.searchInput = search.text!;
    }
}
