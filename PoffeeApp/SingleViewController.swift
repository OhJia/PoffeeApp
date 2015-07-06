//
//  SingleViewController.swift
//  PoffeeApp
//  View controller for single coffee 
//
//  Created by Jiashan Wu on 7/5/15.
//

import UIKit

class SingleViewController: UIViewController {
    
    @IBOutlet var singleUIView: SingleView!
    
    // Share sheet triggered by share button
    // Code from: http://www.dvdowns.com/uiactivityviewcontroller/
    @IBAction func shareButtonIsTouched(sender: AnyObject) {
        let firstActivityItem = "Hey, check out this mediocre site that sometimes posts about Swift!"
        
        let secondActivityItem : NSURL = NSURL(fileURLWithPath: "http://www.dvdowns.com/")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
        ]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    var poffee: JSON!
    var poffeeId: String!
    
    // Requests data from /api/coffee/id 
    // and configures view with JSON data
    func loadPoffees() {
        DNService.poffeesForSection(poffeeId) { (JSON) -> () in
            self.poffee = JSON
            //println(self.poffee)
            self.singleUIView.configureWithSingle(self.poffee)
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
    }
    

}
