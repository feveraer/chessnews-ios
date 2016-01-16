//
//  RankingsModel.swift
//  ChessNews
//
//  Created by Frederic Everaert on 16/01/16.
//  Copyright © 2016 Frederic Everaert. All rights reserved.
//

import Kanna

class RankingsModel {
    var rankings = [Player]()
    let source = "http://www.2700chess.com/"
    
    init() {
        let url = NSURL(string: self.source)!
        var html = NSString()
        do {
            html = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        } catch{ print(error) }
        
        if let doc = Kanna.HTML(html: html as String, encoding: NSUTF8StringEncoding) {
            print(doc.title)
            
            // Search for nodes by CSS
            for link in doc.css("a, link") {
                print(link.text)
                print(link["href"])
            }
            
            // Search for nodes by XPath
            for link in doc.xpath("//a | //link") {
                print(link.text)
                print(link["href"])
            }
        }

        rankings.append(Player(name: "", flag: "", ranking: 99, rating: 2700))
    }
}