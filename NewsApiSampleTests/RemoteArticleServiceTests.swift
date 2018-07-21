//
//  NewsApiSampleTests.swift
//  NewsApiSampleTests
//
//  Created by Vitaliy Kuznetsov on 17/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import XCTest
@testable import NewsApiSample

class RemoteArticleServiceTests: XCTestCase {
    
    fileprivate let baseUrl = "https://newsapi.org"
    fileprivate let authorizationToken = "2f8fd248fe3d459e895cc38d57b13f81"
    fileprivate let apiVersion = "v2"
    
    func testGetUrlComponents() {
        
        let type = "everything"
        let query = "apple"
        let sortBy = "publishedAt"
        let pageSize = "20"
        let page = "1"
        let language = NSLocale.current.languageCode ?? "en"
        let components = RemoteArticleService.getUrlComponentsWithUrl(baseUrl,
                                                             apiVersion: apiVersion,
                                                             type: type,
                                                             query: query,
                                                             sortBy: sortBy,
                                                             pageSize: pageSize,
                                                             page: page,
                                                             language: language)
        XCTAssertNotNil(components, "Components is nil")
        XCTAssertEqual(components?.url?.absoluteString,
                       String.init(format: "%@/%@/%@?q=%@&sortBy=%@&pageSize=%@&page=%@&language=%@", baseUrl, apiVersion, type, query, sortBy, pageSize, page, language))
    }
    
    func testInit(){
        
        let remoteArticleService = RemoteArticleService.init(apiVersion: apiVersion,
                                                             baseUrl: baseUrl,
                                                             authorizationToken: authorizationToken)
        XCTAssertNotNil(remoteArticleService, "RemoteArticleService not initialized")
    }

    func testGetArticles() {
        
        let page = 1
        let perPage = 20
        let remoteArticleService = RemoteArticleService.init(apiVersion: apiVersion,
                                                                baseUrl: baseUrl,
                                                    authorizationToken: authorizationToken)
        let expectArticles = expectation(description: "Wait for articles to download")
        remoteArticleService.getArticles(inAmountOf: perPage, fromPage: page) { (result) in
            
            switch result{
                
                case .success(_ ):
                    break
                
                case .failure(let error):
                    
                    XCTAssertNil(error, error.localizedDescription)
            }
            expectArticles.fulfill()
        };
        waitForExpectations(timeout: 4) { (error) in
            
            XCTAssertNil(error, "Test time out")
        }
    }
}
