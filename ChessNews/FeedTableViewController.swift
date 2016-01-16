//
//  FeedTableViewController.swift
//  ChessNews
//
//  Created by Frederic Everaert on 9/12/15.
//  Copyright © 2015 Frederic Everaert. All rights reserved.
//

import UIKit
import MWFeedParser
import KINWebBrowser

class FeedTableViewController: UITableViewController, MWFeedParserDelegate {

    // the current feed
    var feed: Feed!
    
    // all items of the feed
    var feedItems = [MWFeedItem]()
    
    // setup MWFeedParser
    func request() {
        let url = NSURL(string: feed.url)
        let parser = MWFeedParser(feedURL: url)
        
        // instance of FeedTableViewController confirms to MWFeedParserDelegate
        parser.delegate = self
        
        // download and parse the feed
        parser.parse()
    }
    
    // MWFeedParser delegate functions
    
    func feedParserDidStart(parser: MWFeedParser!) {
        // clear feed items
        feedItems = [MWFeedItem]()
    }
    
    func feedParserDidFinish(parser: MWFeedParser!) {
        // after parse, reload data tableview
        self.tableView.reloadData()
    }
    
    // provides info about the feed
    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
        // display feed title in navigation bar
        self.title = info.title
    }
    
    // provides info about a feed item
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        feedItems.append(item)
    }

    // Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // table view only contains 1 section
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of rows = amount of items in the feed
        return feedItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // configure the cell
        let item = feedItems[indexPath.row] as MWFeedItem
        cell.textLabel!.text = item.title

        return cell
    }
    
    // load the feed
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        request()
    }
    
    // when row is selected
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // get selected feed item
        let item = feedItems[indexPath.row] as MWFeedItem
        
        // setup KINWebBrowser
        let browser = KINWebBrowserViewController()
        // get url from feed item
        let url = NSURL(string: item.link)
        
        // load browser with item url
        browser.loadURL(url)
        
        // push the browser on navigation controller stack
        self.navigationController?.pushViewController(browser, animated: true)
    }

}
