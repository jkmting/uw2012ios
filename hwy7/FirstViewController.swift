//
//  FirstViewController.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-11-19.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit
import Parse

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, QueueCellDelegate {
    @IBOutlet weak var queueCollectionView_ol: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.queueCollectionView_ol.addGestureRecognizer(lpgr)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionReload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ---------- UICollectionView Setting ----------
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Only show queue that has customers lining up
        var showQ = customersQList.count
        for queue in customersQList {
            if queue.numWaiting == 0 {
                showQ--
            }
        }
        return showQ
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Queue", forIndexPath: indexPath) as! CollectionViewCell
        //find the nth Q that has customers lining up (where n = indexPath.row)
        var Qshown = 0
        for customersQ in customersQList {
            if customersQ.numWaiting > 0 {
                if Qshown == indexPath.row {
                    //Found it
                    setQueueViewData(customersQ, cell_: cell)
                    break
                } else {
                    //increase the number of Queue that we alread set the cell to
                    Qshown++
                }
                
            }
        }
        

        return cell
    }
    
    func setQueueViewData(customersQ_: CustomersQ, cell_: CollectionViewCell) {
        var LastQueue = ""
        if customersQ_ == customersQList.last { // the last Queue should have a plus size
            LastQueue = "+"
        }
        cell_.name_ol.text = "Party Size \(customersQ_.qName!)\(LastQueue)"
        cell_.pplInQueue_ol.text = "\(customersQ_.numWaiting)"
        cell_.delegate = self
        cell_.partySize = Int(customersQ_.qName!)! //TODO:make qName to int
        cell_.layer.cornerRadius = 10
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //get the selected cell
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        print("Selected Queue \(cell.name_ol.text): \(indexPath.section), \(indexPath.row)")
        cell.notify(self)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20.0
    }
    // ---------- UICollectionView Setting ----------
    
    func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){
        
        if (gestureRecognizer.state != UIGestureRecognizerState.Began){
            return
        }
        
        let p = gestureRecognizer.locationInView(self.queueCollectionView_ol)
        
        if let indexPath : NSIndexPath = (self.queueCollectionView_ol.indexPathForItemAtPoint(p)){
            print("LongPress detected on indexPath: (\(indexPath.section), \(indexPath.row))")
            let cell = self.queueCollectionView_ol.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
            let customersQ = customersQList[cell.partySize - 1]
            self.performSegueWithIdentifier("Queue2Detail_sg", sender: customersQ)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Queue2Detail_sg" {
            let destVC = segue.destinationViewController as! QueueTableViewController
            destVC.customersQ = (sender as! CustomersQ)
        }
    }
    func presentAlert(controller_: UIViewController) {
        presentViewController(controller_, animated: true, completion: nil)
    }
    
    func collectionReload() {
        queueCollectionView_ol.reloadData()
    }
    
}

