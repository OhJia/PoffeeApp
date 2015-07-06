//
//  PoffeesTableViewController.swift
//  PoffeeApp
//  View controller for all coffee 
//
//  Created by Jiashan Wu on 7/4/15.
//

import UIKit

class PoffeesTableViewController: UITableViewController, PoffeeTableViewCellDelegate {
    
    var poffees: JSON! = []
    
    // Requests data from /api/coffee/ and loads JSON data
    func loadPoffees() {
        DNService.poffeesForSection("") { (JSON) -> () in
            self.poffees = JSON
            self.tableView.reloadData() // reload the whole table view controller
            println("loaded data")
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPoffees()
        
        // Add logo to nav bar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "drip-white")
        imageView.image = image
        
        self.navigationItem.titleView = imageView
        
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem

        // Auto row height for each cell
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poffees.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PoffeeCell") as! PoffeeTableViewCell
        
        let poffee = poffees[indexPath.row]
        
        cell.delegate = self
        cell.configureWithPoffee(poffee)

        return cell
    }

    
    func poffeeTableViewCellDidTouchArrow(cell: PoffeeTableViewCell, sender: AnyObject) {
        performSegueWithIdentifier("SingleSegue", sender: cell)
    }
    
    // MARK: - Pass data to single view controller
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object's id to the single view controller.
        if segue.identifier == "SingleSegue" {
            let toView = segue.destinationViewController as! SingleViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            let poffeeId = poffees[indexPath.row]["id"].string ?? ""
            println(poffeeId)

            toView.poffeeId = poffeeId
        }
    }

}
