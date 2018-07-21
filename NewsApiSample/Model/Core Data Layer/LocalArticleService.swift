//
//  LocalArticleService.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 18/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import UIKit
import CoreData

class LocalArticleService: NSObject, LocalArticleServiceProtocol{
    
    let worker: NewCoreDataWorkerProtocol
    let apiVersion: String
    
    init(apiVersion: String, worker: NewCoreDataWorkerProtocol = NewCoreDataWorker()) {
        
        self.apiVersion = apiVersion
        self.worker = worker
    }
    
    // MARK: - LocalArticleServiceProtocol
    func upsertArticles(_ articles: [Article], completionHandler: @escaping (_ error: Error?)->Void){
        
        worker.upsert(entities: articles) { (error) in
            
            completionHandler(error)
        }
    }
    
    func getArticles(inAmountOf amount: Int, fromPage page: Int, completionHandler: @escaping (Result<[Article]>) -> Void) {
        
        worker.get(with: nil, sortDescriptors: nil, fetchLimit: amount, fetchOffset: (page-1)*amount) {(result: Result<[Article]>) in
            
            switch result{
                
            case .success(let articles):
                
                completionHandler(Result.success(articles))
                break
                
            case .failure(let error):
                
                completionHandler(Result.failure(error))
                break
            }
        }
    }
    
    func purge(completionHandler: @escaping (Error?) -> Void) {
        
        worker.purge(type: Article.self) { (error) in
            
            completionHandler(error)
        }
    }
}








