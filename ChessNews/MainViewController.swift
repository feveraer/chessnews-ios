//
//  MainViewController.swift
//  ChessNews
//
//  Created by Frederic Everaert on 9/12/15.
//  Copyright © 2015 Frederic Everaert. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    var model = FeedsModel()
    var selectedFeed: Feed!

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // number of items in section = amount of feeds
        return model.feeds.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("feedCell", forIndexPath: indexPath) as! FeedCell
        
        // configure the cell
        let feed = model.feeds[indexPath.row]
        
        cell.feedImageView!.image = feed.image
        // little bit of leading space
        cell.feedLabel!.text = "  " + feed.name
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedFeed = model.feeds[indexPath.row]
        self.performSegueWithIdentifier("choose", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // get the new view controller using segue.destinationViewController
        let feedTableViewController = segue.destinationViewController as! FeedTableViewController
        feedTableViewController.feed = selectedFeed
    }
    
}
