//
//  RankingsTableViewController.swift
//  ChessNews
//
//  Created by Frederic Everaert on 16/01/16.
//  Copyright © 2016 Frederic Everaert. All rights reserved.
//

import UIKit

class RankingsTableViewController: UITableViewController {
    
    let model = RankingsModel()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // table view contains only 1 section
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of rows = amount of players
        return model.players.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as! PlayerCell
        
        // configure the cell
        let player = model.players[indexPath.row]
        
        cell.rankingLabel.text = "\(player.ranking)"
        cell.nameLabel.text = player.name
        cell.ratingLabel.text = "\(player.rating)"
        
        let flagUrl = NSURL(string: model.source + player.flag)
        let data = NSData(contentsOfURL: flagUrl!)
        cell.flagView.image = UIImage(data: data!)
        
        return cell
    }
}