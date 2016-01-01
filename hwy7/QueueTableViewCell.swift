//
//  QueueTableViewCell.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-12-31.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit

class QueueTableViewCell: UITableViewCell {

    @IBOutlet weak var name_ol: UILabel!
    @IBOutlet weak var note_ol: UITextView!
    @IBOutlet weak var partySize_ol: UILabel!
    @IBOutlet weak var phone_ol: UILabel!
    @IBOutlet weak var notify_ol: UIButton!
    
    @IBAction func seat_ol(sender: AnyObject) {
    }
    @IBAction func notify_ol(sender: AnyObject) {
        
    }
    @IBAction func eddits_ol(sender: AnyObject) {

    }
    
    
    override func awakeFromNib() {

        super.awakeFromNib()
        note_ol.layer.borderColor = UIColor.blackColor().CGColor
        note_ol.layer.cornerRadius = 5
        note_ol.layer.borderWidth = 1
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
