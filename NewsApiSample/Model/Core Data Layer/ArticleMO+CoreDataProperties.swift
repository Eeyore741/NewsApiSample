//
//  ArticleMO+CoreDataProperties.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 19/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation
import CoreData

extension ArticleMO {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleMO> {
        return NSFetchRequest<ArticleMO>(entityName: "ArticleMO")
    }
    
    @NSManaged public var identifier: String
    @NSManaged public var author: String?
    @NSManaged public var descr: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var sourceName: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    
}
