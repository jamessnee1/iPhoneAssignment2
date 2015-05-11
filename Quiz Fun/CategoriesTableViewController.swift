//
//  CategoriesTableViewController.swift
//  Quiz Fun
//
//  Created by James Snee on 11/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    //categories data
    var categories = [Category]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categories = [Category(categoryName: "General Knowledge", categoryDesc: "This is a general quiz for all ages.", numOfQuestions: 5),
        Category(categoryName: "Geography", categoryDesc: "Geography quiz" , numOfQuestions: 5),
        Category(categoryName: "Pop Culture", categoryDesc: "Pop Culture quiz", numOfQuestions: 5),
        Category(categoryName: "Science", categoryDesc: "Science Quiz", numOfQuestions: 5),
        Category(categoryName: "Australian Politics", categoryDesc: "Politics Quiz", numOfQuestions: 5),
        Category(categoryName: "History", categoryDesc: "History Quiz", numOfQuestions: 5)]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //returns number of rows in section
        return self.categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        //get corresponding category
        let category = self.categories[indexPath.row]
        
        //configure cell
        cell.textLabel!.text = category.categoryName
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("categoriesDetail", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "categoriesDetail" {
            
            let categoriesDetail = segue.destinationViewController as QuestionViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let destinationTitle = self.categories[indexPath.row].categoryName
            let destinationDesc = self.categories[indexPath.row].categoryDesc
            categoriesDetail.title = destinationTitle
            
        
        }
        
    }
    
}
