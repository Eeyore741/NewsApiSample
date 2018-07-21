//
//  RemoteArticleService.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 18/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import UIKit

class RemoteArticleService: NSObject, RemoteArticleServiceProtocol {

    let apiVersion, authorizationToken, baseUrlString: String!
    private let urlSession: URLSession
    private let syncQueue = DispatchQueue(label: "RemoteArticleService.syncQueue")
    
    init(apiVersion: String, baseUrl: String, authorizationToken: String) {
        
        self.apiVersion = apiVersion
        self.baseUrlString = baseUrl
        self.authorizationToken = authorizationToken
        
        let urlSessionConf = URLSessionConfiguration.default
        urlSessionConf.httpAdditionalHeaders = ["Authorization" : self.authorizationToken]
        self.urlSession = URLSession.init(configuration: urlSessionConf)
    }
    
    class func getUrlComponentsWithUrl(_ baseUrl: String!,
                                 apiVersion: String!,
                                 type: String!,
                                 query: String!,
                                 sortBy: String!,
                                 pageSize: String!,
                                 page: String!,
                                 language: String!)->URLComponents?{
        
        let path = String.init(format: "/%@/%@", apiVersion, type)
        let queryParam = URLQueryItem.init(name: "q", value: query)
        let sortParam = URLQueryItem.init(name: "sortBy", value: sortBy)
        let pageSizeParam = URLQueryItem.init(name: "pageSize", value: pageSize)
        let pageParam = URLQueryItem.init(name: "page", value: page)
        let languageParam = URLQueryItem.init(name: "language", value: language)
        
        if var urlComponents = URLComponents.init(string: baseUrl){
            
            urlComponents.path = path
            urlComponents.queryItems = [queryParam, sortParam, pageSizeParam, pageParam, languageParam]
            return urlComponents
        }
        return nil
    }
    
    func getArticles(inAmountOf amount: Int, fromPage page: Int,
                     completionHandler: @escaping (Result<RemoteArticleServiceResponse>) -> Void) {
        
        syncQueue.sync {
            
            guard
                let components = RemoteArticleService.getUrlComponentsWithUrl(self.baseUrlString,
                                                         apiVersion: self.apiVersion,
                                                         type: "everything",
                                                         query: "apple",
                                                         sortBy: "publishedAt",
                                                         pageSize: String.init(amount),
                                                         page: String.init(page),
                                                         language: NSLocale.current.languageCode ?? "en")
                else{
                    completionHandler(.failure(RemoteArticleServiceError.requestError))
                    return
            }
            guard
                let url = components.url else{
                    completionHandler(.failure(RemoteArticleServiceError.requestError))
                    return
            }
            let request = URLRequest.init(url: url,
                                          cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                                          timeoutInterval: 6)
            print(request)
            urlSession.dataTask(with: request) { (data, response, error) in
                
                guard error == nil else {
                    completionHandler(.failure(error!))
                    return }
                
                guard let data = data else {
                    completionHandler(.failure(RemoteArticleServiceError.noDataError))
                    return }
                
                do {
                    
                    let apiStruct = try JSONDecoder().decode(RemoteArticleServiceResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        if apiStruct.status == ResponseStatus.Ok.rawValue{
                            
                            if ((apiStruct.articles?.count ?? 0) > 0){
                                
                                completionHandler(.success(apiStruct))
                            }
                            else{
                                
                                completionHandler(.failure(RemoteArticleServiceError.noDataError))
                            }
                        }
                        else{
                            
                            completionHandler(.failure(RemoteArticleServiceError.dataProcessingError))
                        }
                    }
                } catch let error {
                    
                    print(error)
                    completionHandler(.failure(error))
                }
                }.resume();
        }
        }
}




