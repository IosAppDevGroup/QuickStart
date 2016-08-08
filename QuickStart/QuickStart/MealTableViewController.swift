//
//  MealTableViewController.swift
//  QuickStart
//
//  Created by Flonly on 8/6/16.
//  Copyright © 2016 FlonlyIos. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    // MARK: Properties
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else {
            loadSampleMeals()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(" get meal count = \(meals.count)\n")
        return meals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        print(" new cell = \(cell), cell.nameLabel.text = \(cell.nameLabel.text)\n")
        return cell
    }
    
   
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                
            } else {
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
                print("new meal:\(meal) meal list is \(meals)\n");
            }
           saveMeals()
        }
    }
    
    

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController =  segue.destinationViewController as! MealViewController
            
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
        }else if segue.identifier == "AddItem" {
            print("add new item \n")
        }
    }

    func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1");
        let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 1)!

        let photo2 = UIImage(named: "meal2");
        let meal2 = Meal(name: "meal2", photo: photo2, rating: 3)!

        let photo3 = UIImage(named: "meal3");
        let meal3 = Meal(name: "meal3", photo: photo3, rating: 5)!
        
        let meal4 = Meal(name: "meal4", photo: photo3, rating: 5)!

        meals += [meal1, meal2, meal3, meal4]
    }
    
    
    // MARK: NSCoding
    
    func saveMeals(){
        let isSaveSuccessfull =  NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !isSaveSuccessfull {
            print(" Failed to save meals \n")
        }
    }
    
    func loadMeals()->[Meal]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
}
