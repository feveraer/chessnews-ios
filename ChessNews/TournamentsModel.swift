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
    let dateRegex = "[:alpha:]{3} \\d{1,2}[:alpha:]{2} [:alpha:]{3} \\d{4}"
    let playerRegex = "^[:alpha:]{4,}"
    
    init() {
        let url = NSURL(string: self.source)!
        var html = NSString()
        do {
            html = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        } catch{ print(error) }
        
        // begin scraping
        if let doc = Kanna.HTML(html: html as String, encoding: NSUTF8StringEncoding) {
            print(doc.title)
            
            var tournamentsNames = [String]()
            var tournamentsDetails = [String]()
            var tournamentsStartDates = [NSDate]()
            var tournamentsEndDates = [NSDate]()
            
            // get all tournament specific info
            for tournament in doc.css(".eventInfo") {
                tournamentsNames.append(tournament.css(".eventDetails b").text!)
                tournamentsDetails.append(tournament.css(".tournDetails").text!
                    .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))
                
                // get start and end date for tournament
                let details = tournament.css(".eventDetails").text!
                let dateStrings = matchesForRegexInText(dateRegex, text: details)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "E d M y"
                tournamentsStartDates.append(dateFormatter.dateFromString(dateStrings[0])!)
                tournamentsEndDates.append(dateFormatter.dateFromString(dateStrings[1])!)
            }
            
            // get players, rounds and games
            // 2 info tables per tournament
            var players = [[Player]]()
            var games = [[Game]]()
//            for table in doc.css(".results-table") {
//                let tableIdentifier = table.css("tr > th").text!
//                if tableIdentifier.rangeOfString("^Round ", options: .RegularExpressionSearch) != nil {
//                    // table with rounds and games
//                    print(tableIdentifier)
//                } else {
//                    // table with players and standings
//                    print(table.css("tr:not([class]) td:nth-of-type(2)").text!)
//                }
//            }

            // construct 2d player array, each row belongs to different tournament
            for playersTable in doc.css("table.results-table:nth-of-type(odd)") {
                let playerNames = playersTable.css("tr:not([class]) td:nth-of-type(2)")
                let playerFlags = playersTable.css("tr:not([class]) td:nth-of-type(4)")
                let playerRatings = playersTable.css("tr:not([class]) td:nth-of-type(5)")
                var row = [Player]()
                for i in 0..<playerNames.count {
                    row.append(Player(name: playerNames[i].text!, flag: playerFlags[i].text!, rating: playerRatings[i].text!, ratingChange: nil))
                }
                players.append(row)
            }
            
            // construct 2d games array, each row belongs to a different tournament
            for gamesTable in doc.css("table.results-table:nth-of-type(even)") {
                
            }
        }
    }
    
    // source: http://stackoverflow.com/questions/27880650/swift-extract-regex-matches
    // also filters out "st", "nd", "rd" and "th"
    func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let matches = regex.matchesInString(text,
                options: [], range: NSMakeRange(0, nsString.length))
            let matchesArray = matches.map { nsString.substringWithRange($0.range) as NSString}
            // for date specifically
            var results = [String]()
            for date in matchesArray {
                let strippedDateString = date.stringByReplacingOccurrencesOfString("st|nd|rd|th",
                    withString: "", options: .RegularExpressionSearch, range: NSRange(location: 0, length: date.length))
                results.append(strippedDateString)
            }
            return results
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
}
