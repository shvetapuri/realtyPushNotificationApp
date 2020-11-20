//
//  NewsStore.swift
//  RealtyPushNotification
//
//  Created by Shveta Puri on 11/12/20.
//

import Foundation


class NewsStore {
    static let shared = NewsStore()
    var items: [NewsItem] = []

    //var url_delegate: updateUrl?

    
    func add(item: NewsItem) {
      items.insert(item, at: 0)
      //saveItemsToCache()
        print(item.link)
      //  url_delegate?.newUrlAvailable(url: item.link )

    }
}
