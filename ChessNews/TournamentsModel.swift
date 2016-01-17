//
//  TournamentsModel.swift
//  ChessNews
//
//  Created by Frederic Everaert on 17/01/16.
//  Copyright © 2016 Frederic Everaert. All rights reserved.
//

import Kanna

// contains all ongoing tournaments and their games,
// uses Kanna to scrape theweekinchess.com/live
struct TournamentsModel {
    
    var tournaments = [Tournament]()
    let source = "http://www.theweekinchess.com/live"
    
    init() {
        let url = NSURL(string: self.source)!
        var html = NSString()
        do {
            html = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        } catch{ print(error) }
        
        // begin scraping
        if let doc = Kanna.HTML(html: html as String, encoding: NSUTF8StringEncoding) {
            print(doc.title)
        }
    }
}
