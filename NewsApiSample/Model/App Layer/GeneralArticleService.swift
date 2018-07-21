//
//  GeneralArticleService.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 18/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation

class GeneralArticleService: NSObject, GeneralArticleServiceProtocol {
    
    let localRepository: LocalArticleServiceProtocol
    let remoteRepository: RemoteArticleServiceProtocol
    let apiVersion: String
    let baseUrl: String
    let authorizationToken: String
    
    init(localRepository: LocalArticleServiceProtocol, remoteRepository: RemoteArticleServiceProtocol, apiVersion: String, baseUrl: String, authorizationToken: String) {
        
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
        self.apiVersion = apiVersion
        self.baseUrl = baseUrl
        self.authorizationToken = authorizationToken
        super.init()
    }
    
    func getArticles(inAmountOf amount: Int, fromPage page: Int, _ completionHandler: @escaping (Result<[Article]>) -> Void) {
        localRepository.getArticles(inAmountOf: amount, fromPage: page) { (result) in
            
            switch result {
                
            case .success(let articles):
                
                if articles.count == 0 {
                    
                    self.remoteRepository.getArticles(inAmountOf: amount, fromPage: page) { (result) in
                        
                        switch result{
                            
                        case .success(let response):
                            
                            guard let articles = response.articles else{
                                
                                completionHandler(Result.failure(RemoteArticleServiceError.noDataError))
                                return
                            }
                            self.localRepository.upsertArticles(articles, completionHandler: { (error) in
                                
                                guard error == nil else{
                                    
                                    completionHandler(Result.failure(error!))
                                    return
                                }                                
                                self.getArticles(inAmountOf: amount, fromPage: page, completionHandler)
                            })
                            break
                            
                        case .failure(let error):
                            
                            completionHandler(Result.failure(error))
                            break
                        }
                    }
                }
                else{
                    completionHandler(Result.success(articles))
                }
                break
                
            case .failure(let error):
                
                completionHandler(Result.failure(error))
                break
            }
        }
    }
    
    func updateArticles(_ completionHandler: @escaping (Result<Bool>) -> Void) {
        
        localRepository.purge { (error) in
            
            if error != nil{
                
                completionHandler(Result.failure(error!))
            }
            else{
                
                completionHandler(Result.success(true))
            }
        }
    }
}








