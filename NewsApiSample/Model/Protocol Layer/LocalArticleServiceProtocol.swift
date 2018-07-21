//
//  LocalArticleServiceProtocol.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 18/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation

protocol LocalArticleServiceProtocol{
    
    func upsertArticles(_ articles: [Article], completionHandler: @escaping (_ error: Error?)->Void)
    func getArticles(inAmountOf amount: Int, fromPage page: Int, completionHandler: @escaping (Result<[Article]>)->Void)
    func purge(completionHandler: @escaping (_ success: Error?)->Void)
}

enum LocalArticleServiceError: Error{
    
    case saveError
    case fetchError
    case purgeError
}

//MARK: - Localization
extension LocalArticleServiceError: LocalizedError{
    
    public var errorDescription: String? {
        
        switch self {
            
        case .saveError:
            return NSLocalizedString("LocalArticleServiceError: articles save error", comment: "")
            
        case .fetchError:
            return NSLocalizedString("LocalArticleServiceError: articles fetch error", comment: "")
            
        case .purgeError:
            return NSLocalizedString("LocalArticleServiceError: articles purge error", comment: "")
        }
    }
}









