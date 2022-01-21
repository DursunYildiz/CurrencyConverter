//
//  CoreIRepository.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import Foundation
protocol CoreIRepository {
    /// The entity managed by the repository.
    associatedtype Entity

    /// Gets an array of entities.
    /// - Parameters:
    ///   - predicate: The predicate to be used for fetching the entities.
    ///   - sortDescriptors: The sort descriptors used for sorting the returned array of entities.
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Swift.Result<[Entity], Error>

    /// Creates an entity.
    func create() -> Swift.Result<Entity, Error>

    /// Deletes an entity.
    /// - Parameter entity: The entity to be deleted.
    func delete(entity: Entity) -> Swift.Result<Bool, Error>
}
