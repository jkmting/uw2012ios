//
//  CollectionViewCell.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-11-22.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit

protocol QueueCellDelegate : NSObjectProtocol {
    func collectionReload()
    func presentAlert(controller_: UIViewController) -> Void;
}

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name_ol: UILabel!
    @IBOutlet weak var pplInQueue_ol: UILabel!
    var partySize: Int!
    weak var delegate: QueueCellDelegate?

    func notify(sender: AnyObject) {
        
        let customerQ = customersQList[partySize - 1]
        if customerQ.numWaiting == 0 {
            return
        }
        let firstCustomer = customerQ.peek()!
        let confirmAlert = UIAlertController(title: "Notify Customer", message: "Confirm to notify Customer \n" +
            "Name  : \(firstCustomer.name)\n" +
            "Phone : \(firstCustomer.phone)\n", preferredStyle: UIAlertControllerStyle.Alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            let customerQ = customersQList[self.partySize - 1]
            print("Name:\(self.name_ol.text!)")
            print("\(customerQ.qName)")
            customerQ.seat()
            //disable seat button if queue empty

            self.delegate?.collectionReload()
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        if delegate?.respondsToSelector("showAlert:") != nil {
            delegate?.presentAlert(confirmAlert)
        }
    }

}
