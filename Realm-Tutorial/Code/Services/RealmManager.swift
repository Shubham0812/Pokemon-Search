//
//  RealmManager.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 28/02/21.
//

import Foundation
import RealmSwift

private protocol RealmOperations {
    /// write operation
    static func write<T: Object>(_ object: T?, block: @escaping ((Realm, T?) -> Void))
    ///
    /// adds a single object to Realm
    static func add(_ object: Object)
    /// adds a list of objects to Realm
    static func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object
    
    /// gets objects from Realm that satisfy the given predicate
    static func get<R: Object>(fromEntity entity : R.Type, withPredicate predicate: NSPredicate?,
                               sortedByKey sortKey: String?, inAscending isAscending: Bool) -> Results<R>
    
    /// deletes a single object from Realm
    static func delete(_ object: Object)
    
    /// deletes a list of object from Realm
    static func delete<S: Sequence>(_ objects: S) where S.Iterator.Element: Object
    
    /// deletes an Entity from Realm based  on the given predicate
    static func delete(fromEntity entity: Object.Type, withPredicate predicate: NSPredicate?)
    
    /// updates and overwrites a Realm object
    static func update<T: Object>(_ object: T, block: @escaping ((T) -> Void))
}


class RealmManager {
    
    // MARK:- functions
    static func realmConfig() -> Realm.Configuration {
        return Realm.Configuration(schemaVersion: 2, migrationBlock: { (migration, oldSchemaVersion) in
            /// Migration block. Useful when you upgrade the schema version.
            
        })
    }
    
    private static func realmInstance() -> Realm {
        do {
            let newRealm = try Realm(configuration: realmConfig())
            return newRealm
        } catch {
            print(error)
            fatalError("Unable to create an instance of Realm")
        }
    }
}

extension RealmManager: RealmOperations {
    /// Writes to Realm
    fileprivate static func write<T: Object>(_ object: T? = nil, block: @escaping ((Realm, T?) -> Void)) {
        var objectRef : ThreadSafeReference<T>? = nil
        
        // Check if object is not nil, and it is a Realm Managed Object. Convert it to a thread safe reference.
        if let object = object, object.realm != nil {
            objectRef = ThreadSafeReference(to: object)
        }
        
        DispatchQueue(label: "realm").sync {
            autoreleasepool {
                let currentRealm = realmInstance()
                var newObject : T? = nil
                // Resolve object to Realm Object. If that is not possible take newObject as the original Object,
                if let objectRef = objectRef {
                    guard let resolvedObject = currentRealm.resolve(objectRef) else { return }
                    newObject = resolvedObject
                } else {
                    newObject = object
                }
                
                if currentRealm.isInWriteTransaction {
                    return
                } else {
                    do {
                        try currentRealm.write {
                            block(currentRealm, newObject)
                        }
                    } catch {
                        return
                    }
                }
            }
        }
    }
    
    // MARK:- ADD functions
    /// adds an object to Realm
    static func add(_ object: Object) {
        Self.write { (realmInstance, _) in
            realmInstance.add(object, update: .all)
        }
    }
    
    /// adds a list of objects to Realm
    static func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        Self.write { (realmInstance, _) in
            realmInstance.add(objects, update: .all)
        }
    }
    
    
    // MARK:- GET function
    static func get<R: Object>(fromEntity entity : R.Type, withPredicate predicate: NSPredicate? = nil, sortedByKey sortKey: String? = nil, inAscending isAscending: Bool = true) -> Results<R> {
        var objects = realmInstance().objects(entity)
        if predicate != nil {
            objects = objects.filter(predicate!)
        }
        if sortKey != nil {
            objects = objects.sorted(byKeyPath: sortKey!, ascending: isAscending)
        }
        
        return objects
    }
    
    // MARK:- DELETE functions
    static func delete(_ object: Object) {
        Self.write(object) { (realmInstance, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            realmInstance.delete(newObject)
        }
    }
    
    /// deletes a list of elements from Realm
    static func delete<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        Self.write { (realmInstance, _) in
            realmInstance.delete(objects)
        }
    }
    
    /// deletes an Entity from Realm, a predicate can be given
    static func delete(fromEntity entity: Object.Type, withPredicate predicate: NSPredicate? = nil) {
        Self.delete(Self.get(fromEntity: entity, withPredicate: predicate))
    }
    
    // MARK:- UPDATE function
    static func update<T: Object>(_ object: T, block: @escaping ((T) -> Void)) {
        guard !object.isInvalidated else {
            return
        }
        
        Self.write(object) { (_, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            block(newObject)
        }
    }
}

/// Write your custom get and other Realm functions here
extension RealmManager {
    
    // MARK:- functions
    func getPokemonsByID(offset: Int, limit: Int) -> [Pokemon] {
        let pokemons = RealmManager.get(fromEntity: Pokemon.self, withPredicate: NSPredicate(format: "id >= %d AND id < %d", offset, limit))
        return Array(pokemons)
    }
    
    func getPokemonsByName(query: String) -> [Pokemon] {
        let pokemons = RealmManager.get(fromEntity: Pokemon.self, withPredicate: NSPredicate(format: "name beginswith[cd] %@", query),
                                        sortedByKey: "id", inAscending: true)
        return Array(pokemons)
    }
    
    func getPokemonsByType(query: String) -> [Pokemon] {
        let pokemons = RealmManager.get(fromEntity: Pokemon.self, withPredicate: NSPredicate(format: "type beginswith[cd] %@", query),
                                        sortedByKey: "id", inAscending: true)
        return Array(pokemons)
    }
    
}
