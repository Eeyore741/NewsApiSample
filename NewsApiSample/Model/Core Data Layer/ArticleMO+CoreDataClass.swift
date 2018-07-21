//
//  ArticleMO.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 19/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import UIKit
import CoreData

public class ArticleMO: NSManagedObject {}

extension ArticleMO: ManagedObjectProtocol {
    
    func toEntity() -> Article? {
        
        var source = Source()
        source.name = sourceName
        return Article(source: source, author: self.author, title: self.title, description: self.descr, url: self.url, urlToImage: self.urlToImage, publishedAt: Article.stringFromDate(self.publishedAt))
    }
}

extension Article: ManagedObjectConvertible {
    
    func toManagedObject(in context: NSManagedObjectContext) -> ArticleMO? {
        
        let article = ArticleMO.getOrCreateSingle(with: identifier, from: context)
        print("Article id \(identifier)")
        article.sourceName = source?.name
        article.author = author
        article.descr = description
        article.title = title
        article.urlToImage = urlToImage
        article.url = url
        article.publishedAt = Article.dateFromString(publishedAt)
        return article
    }
}


