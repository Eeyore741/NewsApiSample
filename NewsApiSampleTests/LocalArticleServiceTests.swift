//
//  LocalArticleServiceTests.swift
//  NewsApiSampleTests
//
//  Created by Vitaliy Kuznetsov on 21/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import XCTest
@testable import NewsApiSample

class LocalArticleServiceTests: XCTestCase {
    
    fileprivate let apiVersion = "v2"
    
    func testInit(){
        
        let localArticleService = LocalArticleService.init(apiVersion: apiVersion)
        XCTAssertNotNil(localArticleService, "LocalArticleService not initialized")
    }
    
    func testPurgeArticles(){
        
        let localArticleService = LocalArticleService.init(apiVersion: apiVersion)
        let expectPurge = expectation(description: "Expect articles purge")
        localArticleService.purge { (error) in
            
            XCTAssertNil(error, "LocalArticleService purge error \(error?.localizedDescription ?? "empty")")
            expectPurge.fulfill()
        }
        waitForExpectations(timeout: 4) { (error) in
            
            XCTAssertNil(error, error?.localizedDescription ?? "LocalArticleService purge timeout" )
        }
    }
    
    func testUpsertArticles(){
        
        let localArticleService = LocalArticleService.init(apiVersion: apiVersion)
        
        var source = Source()
        source.id = "9"
        source.name = "Best News Provider"
        
        var article = Article()
        article.author = "Famous author you've never heard of:)"
        article.description = "My super article"
        article.publishedAt = "2018-07-20T15:52:07Z"
        article.url = "google.com"
        article.urlToImage = "https://www.google.ru/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
        article.title = "Awesome title"
        article.source = source
        
        let expectUpsert = expectation(description: "LocalArticleService upsert expectation")
        localArticleService.upsertArticles([article,article]) { (error) in
            
            XCTAssertNil(error, error?.localizedDescription ?? "LocalArticleService upsert error")
            expectUpsert.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertNil(error, error?.localizedDescription ?? "LocalArticleService upsert timeout")
        }
    }
    
    func testGetArticles(){
        
        let localArticleService = LocalArticleService.init(apiVersion: apiVersion)
        let expectGet = expectation(description: "Expect articles get")
        localArticleService.getArticles(inAmountOf: 1, fromPage: 1) { (result) in
            
            switch result{
                
            case .success(let articles):
                XCTAssertNotNil(articles, "LocalArticleService get result is nil")
                XCTAssertEqual(articles.count, 1, "LocalArticleService count != 1 (duplicate error possible)")
                
            case .failure(let error):
                XCTAssertNil(error, "LocalArticleService get error \(error.localizedDescription)")
                break
            }
            expectGet.fulfill()
        }
        waitForExpectations(timeout: 4) { (error) in
            
            XCTAssertNil(error, error?.localizedDescription ?? "LocalArticleService get timeout" )
        }
    }
}






