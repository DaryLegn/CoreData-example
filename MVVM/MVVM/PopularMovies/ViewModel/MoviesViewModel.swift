//
//  ViewModel.swift
//  MVVM
//

import Foundation
import CoreData

class MoviesViewModel {

    // MARK: - Properties
    private let manager = CoreDataManager.shared

    // MARK: - CRUD Operations
    func saveMovie(_ movie: [MoviesModel]) {
        _ = movie.map{manager.createEntity(model: $0)}
        manager.save()
    }

    func clearData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Movies.self))
        if let result = try? manager.persistentContainer.viewContext.fetch(fetchRequest) {
            for object in result {
                manager.persistentContainer.viewContext.delete(object as! NSManagedObject)
            }
        }
    }
}
