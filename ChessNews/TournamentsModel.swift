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
    
    init() {
        let url = NSURL(string: self.source)!
        var html = NSString()
        do {
            html = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        } catch{ print(error) }
        
        // begin scraping
        if let doc = Kanna.HTML(html: html as String, encoding: NSUTF8StringEncoding) {
            print(doc.title)
            
            for tournament in doc.css(".eventInfo") {
                let tournamentName = tournament.css(".eventDetails b").text!
                let tournamentDetails = tournament.css(".tournDetails").text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                let details = tournament.css(".eventDetails").text!
                let dateStrings = matchesForRegexInText(dateRegex, text: details)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "E d M y"
                print(dateFormatter.dateFromString(dateStrings[0]))
            }
        }
    }
    
    // source: http://stackoverflow.com/questions/27880650/swift-extract-regex-matches
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
