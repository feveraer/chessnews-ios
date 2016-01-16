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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.players.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as! PlayerCell
        
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