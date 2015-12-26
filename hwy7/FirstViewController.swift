//
//  FirstViewController.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-11-19.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, QueueCellDelegate {
    @IBOutlet weak var queueCollectionView_ol: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        collectionReload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customersQList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Queue", forIndexPath: indexPath) as! CollectionViewCell
        let customersQ = customersQList[indexPath.row]
        
        cell.name_ol.text = customersQ.qName
        cell.pplInQueue_ol.text = "\(customersQ.numWaiting)"
        cell.delegate = self
        
        //set up contents in object queue
        /*
        cell.pplInQueue.backgroundColor = UIColor.clearColor()
        
        cell.pplInQueue.layer.cornerRadius = 80
        cell.pplInQueue.layer.borderWidth = 10
        cell.pplInQueue.layer.borderColor = UIColor.blackColor().CGColor
        cell.seat.layer.borderColor = UIColor.blackColor().CGColor
        cell.eddit.layer.borderColor = UIColor.blackColor().CGColor
        */
        return cell
    }
    
    func presentAlert(controller_: UIViewController) {
        presentViewController(controller_, animated: true, completion: nil)
    }
    
    func collectionReload() {
        queueCollectionView_ol.reloadData()
    }
    
}

