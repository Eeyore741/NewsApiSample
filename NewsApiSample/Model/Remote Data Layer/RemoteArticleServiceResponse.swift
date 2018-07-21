//
//  ResponseApi.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 18/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import UIKit

enum ResponseStatus: String{
    
    case Ok = "ok"
    case Error = "error"
}

struct RemoteArticleServiceResponse: Decodable {
    
    var status: String
    var totalResults: Int?
    var code: String?
    var message: String?
    var articles: [Article]?
}
