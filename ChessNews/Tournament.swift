//
//  Tournament.swift
//  ChessNews
//
//  Created by Frederic Everaert on 17/01/16.
//  Copyright © 2016 Frederic Everaert. All rights reserved.
//

import UIKit

struct Tournament {

    let name: String
    let details: String
    let startDate: NSDate
    let endDate: NSDate
    
    // to later implement standings for the tournament
    let participants: [Player]
    
    // 2d array games where each row represents a round
    let games: [[Game]]
}
