//
//  Result.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 17/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation

enum Result<T>{
    
    case success(T)
    case failure(Error)
}

