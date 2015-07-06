//
//  SingleView.swift
//  PoffeeApp
//  View for single coffee
//
//  Created by Jiashan Wu on 7/5/15.
//

import UIKit

class SingleView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var txt: UITextView!
    @IBOutlet weak var picImageView: AsyncImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    // Configure content for single coffee
    func configureWithSingle(single: JSON) {
        let title = single["name"].string ?? ""
        let text = single["desc"].string ?? ""
        let picture_url = single["image_url"].string ?? ""
        if picture_url != "" {
            let url = NSURL(string: picture_url)
            let data = NSData(contentsOfURL: url!)
            picImageView.image = UIImage(data: data!)
        }
        let time = single["last_updated_at"].string ?? ""
        let updatedTime = "Updated " + timeAgoSinceDate(dateFromString(time, "yyyy-MM-dd HH:mm:ss.zzzzzz"), true) + " ago"
        titleLabel.text = title
        txt.text = text
        timeLabel.text = updatedTime

    }

}
