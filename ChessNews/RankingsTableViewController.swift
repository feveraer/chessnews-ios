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
        for player in model.rankings {
            print(player)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}