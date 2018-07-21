//
//  NewCoreDataWorkerProtocolMock.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 21/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import UIKit

class NewCoreDataWorkerProtocolMock: NSObject, NewCoreDataWorkerProtocol {
    func upsert<Entity>(entities: [Entity], completion: @escaping (Error?) -> Void) where Entity : ManagedObjectConvertible {
        
    }
    
    func purge<Entity>(type: Entity.Type, completion: @escaping (Error?) -> Void) where Entity : ManagedObjectConvertible {
        
    }
}
