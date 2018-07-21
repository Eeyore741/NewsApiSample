//
//  ArticleTests.swift
//  NewsApiSampleTests
//
//  Created by Vitaliy Kuznetsov on 22/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import XCTest
@testable import NewsApiSample

class ArticleTests: XCTestCase {
    
    fileprivate let author = "Fancy One"
    fileprivate let publishedAt = "2018-07-20T15:52:07Z"
    fileprivate let sourceName = "Most reliable ever"
    
    func testIndentifier(){
        
        var source = Source()
        source.name = sourceName
        var article = Article()
        article.author = author
        article.publishedAt = publishedAt
        article.source = source
        XCTAssertEqual(article.identifier, "-6450950369416143454", "ArticleTests identifier test error")
    }
    
    func testDateFromString(){
        
        let date = Article.dateFromString(publishedAt)
        XCTAssertNotNil(date, "ArticleTests testDateFromString = nil")
        XCTAssertEqual(date?.hashValue, 1469964747758334247, "ArticleTests testDateFromString equal error")
    }
}







