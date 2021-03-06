//
//  CoreDataWorker2.swift
//  BetterCoreData
//
//  Created by Michal Wojtysiak on 23/11/2016.
//  Copyright © 2016 Michal Wojtysiak. All rights reserved.
//

import Foundation

enum CoreDataWorkerError: Error{
    case cannotFetch(String)
    case cannotSave(Error)
    case cannotPurge(Error)
}

protocol NewCoreDataWorkerProtocol {
    func get<Entity: ManagedObjectConvertible>
        (with predicate: NSPredicate?,
         sortDescriptors: [NSSortDescriptor]?,
         fetchLimit: Int?,
         fetchOffset: Int?,
         completion: @escaping (Result<[Entity]>) -> Void)
    func upsert<Entity: ManagedObjectConvertible>
        (entities: [Entity],
         completion: @escaping (Error?) -> Void)
    func purge<Entity: ManagedObjectConvertible>
        (type: Entity.Type, completion: @escaping (Error?) -> Void)
    
}

extension NewCoreDataWorkerProtocol {
    func get<Entity: ManagedObjectConvertible>
        (with predicate: NSPredicate? = nil,
         sortDescriptors: [NSSortDescriptor]? = nil,
         fetchLimit: Int? = nil,
         fetchOffset: Int?  = nil,
         completion: @escaping (Result<[Entity]>) -> Void) {
        get(with: predicate,
            sortDescriptors: sortDescriptors,
            fetchLimit: fetchLimit,
            completion: completion)
    }
}

class NewCoreDataWorker: NewCoreDataWorkerProtocol {
    let coreData: CoreDataServiceProtocol
    
    init(coreData: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreData = coreData
    }
    
    func get<Entity: ManagedObjectConvertible>
        (with predicate: NSPredicate?,
         sortDescriptors: [NSSortDescriptor]?,
         fetchLimit: Int?,
         fetchOffset: Int?,
         completion: @escaping (Result<[Entity]>) -> Void) {
        coreData.performForegroundTask { context in
            do {
                let fetchRequest = Entity.ManagedObject.fetchRequest()
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                if let fetchLimit = fetchLimit {
                    fetchRequest.fetchLimit = fetchLimit
                }
                if let fetchOffset = fetchOffset {
                    fetchRequest.fetchOffset = fetchOffset
                }
                let results = try context.fetch(fetchRequest) as? [Entity.ManagedObject]
                let items: [Entity] = results?.compactMap { $0.toEntity() as? Entity } ?? []
                completion(.success(items))
            } catch {
                let fetchError = CoreDataWorkerError.cannotFetch("Cannot fetch error: \(error))")
                completion(.failure(fetchError))
            }
        }
    }
    
    func upsert<Entity: ManagedObjectConvertible>
        (entities: [Entity],
         completion: @escaping (Error?) -> Void) {
        
        coreData.performBackgroundTask { context in
            _ = entities.compactMap({ (entity) -> Entity.ManagedObject? in
                return entity.toManagedObject(in: context)
            })
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(CoreDataWorkerError.cannotSave(error))
            }
        }
    }
    
    func purge<Entity: ManagedObjectConvertible>
        (type: Entity.Type, completion: @escaping (Error?) -> Void){
        coreData.performForegroundTask { context in
            do {
                let fetchRequest = Entity.ManagedObject.fetchRequest()
                let results = try context.fetch(fetchRequest) as! [Entity.ManagedObject]
                
                for mo in results as [Entity.ManagedObject]{
                    
                    context.delete(mo)
                }
                try context.save()
                completion(nil)
            } catch {
                completion(CoreDataWorkerError.cannotSave(error))
            }
        }
    }
}

