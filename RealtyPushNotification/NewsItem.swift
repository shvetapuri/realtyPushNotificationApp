//
//  NewsItem.swift
//  RealtyPushNotification
//
//  Created by Shveta Puri on 11/12/20.
//

import Foundation
struct NewsItem: Codable {
    
    let title: String
    let date: Date
    let link: String
    
    
    @discardableResult
    static func makeNewsItem(_ notification: [String: AnyObject]) -> NewsItem? {
      guard
        let news = notification["alert"]?.title as? String,
        let url = notification["alert"]?.url as? String
      else {
        return nil
      }

      let newsItem = NewsItem(title: news, date: Date(), link: url)
      let newsStore = NewsStore.shared
      newsStore.add(item: newsItem)
        
//
//      NotificationCenter.default.post(
//        name: NewsFeedTableViewController.refreshNewsFeedNotification,
//        object: self)

      return newsItem
    }
}
