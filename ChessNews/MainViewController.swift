//
//  MainViewController.swift
//  ChessNews
//
//  Created by Frederic Everaert on 9/12/15.
//  Copyright © 2015 Frederic Everaert. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var feedsStack: UIStackView!
    
    var model = FeedsModel()
    var selectedFeed: Feed!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for view in feedsStack.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        for feed in model.feeds {
            let button = UIButton(type: .System)
            button.setTitle(feed.name, forState: .Normal)
            button.addTarget(self, action: "choose:", forControlEvents: .TouchUpInside)

            feedsStack.addArrangedSubview(button)
        }
    }

    func choose(sender: UIButton) {
        selectedFeed = model.feeds.filter {
            $0.name == sender.titleLabel!.text }.first!
        performSegueWithIdentifier("choose", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        let feedTableViewController = segue.destinationViewController as! FeedTableViewController
        feedTableViewController.feed = selectedFeed
        
        // Pass the selected object to the new view controller.
    }
    
}
