# Chessnews

This iOS app allows you to follow the latest chess news by fetching RSS streams.

## Features
<img src="https://raw.githubusercontent.com/feveraer/chessnews-ios/master/newsitems.png" width=200 height=350/> 
<img src="https://raw.githubusercontent.com/feveraer/chessnews-ios/master/article.png" width=200 height=350/>
<img src="https://raw.githubusercontent.com/feveraer/chessnews-ios/master/ratings.png" width=200 height=350/>
* Browse the latest chess news
* Watch the live ratings list, courtesy of [2700chess](http://www.2700chess.com)

## Used technologies
* Swift
* MVC and delegation patterns
* Auto layout
* Storyboards, segues, viewcontrollers like UITabBarController and UINavigationController
* UITableView

## Used 3rd party frameworks
* [KINWebBrowser](https://github.com/dfmuir/KINWebBrowser) to view a news article
* [MWFeedParser](https://github.com/mwaterfall/MWFeedParser) to parse RSS feed data
* [Kanna](https://github.com/tid-kijyun/Kanna) to parse HTML for the live rankings

## Also
This project was built with XCode 7, Swift 2 and targets iOS 9. It makes use of [CocoaPods](https://cocoapods.org/) for the 3rd party frameworks. The Podfile is included in the repo.
