//
//  FirstViewController.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-11-19.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit
import Parse

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, QueueCellDelegate {
    @IBOutlet weak var queueCollectionView_ol: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        return customersQList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Queue", forIndexPath: indexPath) as! CollectionViewCell
        let customersQ = customersQList[indexPath.row]
        
        cell.name_ol.text = "Party Size \(customersQ.qName!)"
        cell.pplInQueue_ol.text = "\(customersQ.numWaiting)"
        cell.delegate = self
        cell.partySize = Int(customersQ.qName!)! //TODO:make qName to int
        cell.layer.cornerRadius = 10
        return cell
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
    func presentAlert(controller_: UIViewController) {
        presentViewController(controller_, animated: true, completion: nil)
    }
    
    func collectionReload() {
        queueCollectionView_ol.reloadData()
    }
    
}

