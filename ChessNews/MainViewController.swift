//
//  MainViewController.swift
//  ChessNews
//
//  Created by Frederic Everaert on 9/12/15.
//  Copyright © 2015 Frederic Everaert. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController {

    // contains feed buttons
    // @IBOutlet weak var feedsStack: UIStackView!
    
    var model = FeedsModel()
    var selectedFeed: Feed!
    
//    override func viewDidLoad() {
//        // first remove template buttons from storyboard
//        for view in feedsStack.arrangedSubviews {
//            view.removeFromSuperview()
//        }
//        
//        // add a button to feedsStack for each feed in model
//        for feed in model.feeds {
//            let button = UIButton(type: .System)
//            button.setTitle(feed.name, forState: .Normal)
//            button.addTarget(self, action: "choose:", forControlEvents: .TouchUpInside)
//
//            feedsStack.addArrangedSubview(button)
//        }
//    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // number of items in section = amount of feeds
        return model.feeds.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("feedCell", forIndexPath: indexPath) as! FeedCell
        
        // configure the cell
        let feed = model.feeds[indexPath.row]
        
        cell.feedImageView!.image = feed.image
        cell.feedLabel!.text = feed.name
        
        return cell
    }
    
    // fired when clicked on a feed button
//    func choose(sender: UIButton) {
//        selectedFeed = model.feeds.filter {
//            $0.name == sender.titleLabel!.text }.first!
//        performSegueWithIdentifier("choose", sender: self)
//    }
    
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
