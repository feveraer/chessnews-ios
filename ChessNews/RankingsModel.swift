//
//  RankingsModel.swift
//  ChessNews
//
//  Created by Frederic Everaert on 16/01/16.
//  Copyright © 2016 Frederic Everaert. All rights reserved.
//

import Kanna

//  This model contains all players featured on 2700chess.com, uses Kanna to scrape the website.
struct RankingsModel {
    var players = [Player]()
    let source = "http://www.2700chess.com"
    
    init() {
        let url = NSURL(string: self.source)!
        var html = NSString()
        do {
            html = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        } catch{ print(error) }
        
        // begin scraping
        if let doc = Kanna.HTML(html: html as String, encoding: NSUTF8StringEncoding) {

            // each player is a row in a table with class "list"
            for player in doc.css(".list tr") {
                let playerName = player.css(".name > span").text!
                let playerFlag = player.css(".print-country").first!["src"]!
                let playerRank = player.css(".live_pos").text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                let playerRating = player.css(".live_standard_rating").text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                players.append(Player(name: playerName, flag: playerFlag, ranking: Int(playerRank)!, rating: Float(playerRating)!))
            }
        }
    }
}