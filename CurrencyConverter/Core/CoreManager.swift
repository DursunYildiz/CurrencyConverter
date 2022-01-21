//
//  CoreManager.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import Foundation
import CoreData
class CoreManager  {

    var persistentContainer: NSPersistentContainer
    var dbName : String
    init(dbName: String ) {
        self.dbName = dbName
        persistentContainer = NSPersistentContainer(name: dbName)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func deleteDB () {
      
            let storeContainer =
                persistentContainer.persistentStoreCoordinator

            // Delete each existing persistent store
            for store in storeContainer.persistentStores {
                do { try storeContainer.destroyPersistentStore(
                    at: store.url!,
                    ofType: store.type,
                    options: nil
                )
                } catch {}
            }

            // Re-create the persistent container
            persistentContainer = NSPersistentContainer(
                name: dbName // the name of
                // a .xcdatamodeld file
            )

            // Calling loadPersistentStores will re-create the
            // persistent stores
            persistentContainer.loadPersistentStores {
                _, _ in
                // Handle errors
            }
        
    }


    
}
