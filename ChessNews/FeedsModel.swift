//
//  FeedsModel.swift
//  ChessNews
//
//  Created by Frederic Everaert on 15/01/16.
//  Copyright © 2016 Frederic Everaert. All rights reserved.
//

struct FeedsModel {
    var feeds = [
        Feed(name: "Chessdom", url: "http://www.chessdom.com/feed/"),
        Feed(name: "The Week in Chess", url: "http://www.theweekinchess.com/twic-rss-feed"),
        Feed(name: "Chess Daily News", url: "https://chessdailynews.com/feed/"),
        Feed(name: "Reddit /r/chess", url: "http://www.reddit.com/r/chess.rss")
    ]
}