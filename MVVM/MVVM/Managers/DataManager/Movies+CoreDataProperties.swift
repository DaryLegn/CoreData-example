//
//  Movies+CoreDataProperties.swift
//  MVVM

import Foundation
import CoreData

extension Movies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movies> {
        return NSFetchRequest<Movies>(entityName: "Movies")
    }

    @NSManaged public var name: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var overview: String?

}

