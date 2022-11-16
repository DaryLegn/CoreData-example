//
//  CoreDataManager.swift
//  MVVM
//

import Foundation
import CoreData

final class CoreDataManager {

    // MARK: - Properties
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    // MARK: - Init
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreDateModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to init CoreData \(error)")
            }
        }
    }

    // MARK: - CRUD Operations
    func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print("Failed to save movies \(error)")
            }
        }
    }

    func createEntity(model: MoviesModel) -> NSManagedObject? {
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "Movies", into: persistentContainer.viewContext) as? Movies {
            entity.name = model.title
            entity.posterPath = model.posterPath
            entity.overview = model.overview
            return entity
        }
        return nil
    }
}
