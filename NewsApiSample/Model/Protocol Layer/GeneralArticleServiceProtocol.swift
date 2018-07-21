//
//  GeneralArticleServiceProtocol.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 19/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation

protocol GeneralArticleServiceProtocol {
    
    func getArticles(inAmountOf amount: Int, fromPage page: Int,_ completionHandler: @escaping (Result<[Article]>) -> Void)
    func updateArticles(_ completionHandler: @escaping (Result<Bool>) -> Void)
}
