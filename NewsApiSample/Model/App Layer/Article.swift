//
//  Article.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 19/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation

struct Article: Decodable, Equatable {
    
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    
    var identifier: String {
        
        get{
            let hash = (source?.name?.hashValue ?? 0) ^ (author?.hashValue ?? 0) ^ (publishedAt?.hashValue ?? 0)
            return "\(hash)"
        }
    }
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
    static func dateFromString(_ publishedAt: String?) -> Date?{
        
        guard let publishedAt = publishedAt else{
            return nil
        }
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = Article.dateFormat
        return dateFormatter.date(from: publishedAt)
    }
    
    static func stringFromDate(_ date: Date?) -> String?{
        
        guard let date = date else {
            return nil
        }
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = Article.dateFormat
        return dateFormatter.string(from: date)
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

struct Source: Decodable{
    
    var id: String?
    var name: String?
}
