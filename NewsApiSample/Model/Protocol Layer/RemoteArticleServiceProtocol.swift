//
//  RemoteArticleServiceProtocol.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 18/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation
import UIKit

protocol RemoteArticleServiceProtocol {
    
    func getArticles(inAmountOf amount: Int, fromPage page: Int, completionHandler: @escaping (Result<RemoteArticleServiceResponse>) -> Void)
}

public enum RemoteArticleServiceError: Error{
    
    case requestError
    case noDataError
    case dataProcessingError
}

//MARK: - Localization
extension RemoteArticleServiceError: LocalizedError {
    
    public var errorDescription: String? {
        
        switch self {
            
        case .noDataError:
            return NSLocalizedString("RemoteArticleServiceError: articles fetch error", comment: "")
            
        case .dataProcessingError:
            return NSLocalizedString("RemoteArticleServiceError: articles processing error", comment: "")
            
        case .requestError:
            return NSLocalizedString("RemoteArticleServiceError: articles request error", comment: "")
        }
    }
}



