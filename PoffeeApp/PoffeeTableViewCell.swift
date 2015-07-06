//
//  PoffeeTableViewCell.swift
//  PoffeeApp
//  View for each table cell
//
//  Created by Jiashan Wu on 7/4/15.
//

import UIKit

// Create class for delegate to send IBAction to PoffeesTableViewController
protocol PoffeeTableViewCellDelegate : class {
    func poffeeTableViewCellDidTouchArrow(cell: PoffeeTableViewCell, sender: AnyObject)
}

class PoffeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var picImageView: AsyncImageView!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    weak var delegate: PoffeeTableViewCellDelegate? // New delegate

    @IBAction func arrowButtonDidTouch(sender: AnyObject) {
        delegate?.poffeeTableViewCellDidTouchArrow(self, sender: sender)
    }
    
    // Configure content in each cell
    func configureWithPoffee(poffee: JSON) {
        let title = poffee["name"].string ?? ""
        let text = poffee["desc"].string ?? ""
        let picture_url = poffee["image_url"].string
        
        picImageView.url = picture_url?.toURL()
        if picture_url != "" {
            let data = NSData(contentsOfURL: picImageView.url!)
            picImageView.image = UIImage(data: data!)
        }

        titleLabel.text = title
        infoTextView.text = text
    }
}
