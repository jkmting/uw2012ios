//
//  CollectionViewCell.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-11-22.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit

protocol QueueCellDelegate : NSObjectProtocol {
    func showAlert(controller: UIViewController) -> Void;
}

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name_ol: UILabel!
    @IBOutlet weak var pplInQueue_ol: UILabel!
    @IBOutlet weak var seat_ol: UIButton!
    weak var delegate: FirstViewController?

    @IBAction func seat(sender: AnyObject) {
        
        let customerQ = customersQList[Int(name_ol.text!)! - 1]
        if customerQ.numWaiting == 0 {
            return
        }
        let firstCustomer = customerQ.peek()!
        let confirmAlert = UIAlertController(title: "Seat Customer", message: "Push confirm to Seat Customer \n" +
            "Name  : \(firstCustomer.name)\n" +
            "Phone : \(firstCustomer.phone)\n", preferredStyle: UIAlertControllerStyle.Alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            let customerQ = customersQList[Int(self.name_ol.text!)! - 1]
            print("Name:\(self.name_ol.text!)")
            print("\(customerQ.qName)")
            customerQ.seat()
            //disable seat button if queue empty

            self.delegate?.queueCollectionView_ol.reloadData()
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        if delegate?.respondsToSelector("showAlert:") != nil {
            delegate?.showAlert(confirmAlert)
        }
    }
}
