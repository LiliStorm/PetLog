//
//  PetEntity+CoreDataProperties.swift
//  PetLog
//
//  Created by Lili Storm on 02282021--.
//
//

import Foundation
import CoreData


extension PetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PetEntity> {
        return NSFetchRequest<PetEntity>(entityName: "PetEntity")
    }

    @NSManaged public var age: Int16
    @NSManaged public var birthday: Date?
    @NSManaged public var breed: String?
    @NSManaged public var name: String
    @NSManaged public var species: String?
    @NSManaged public var id: UUID

}

extension PetEntity : Identifiable {

}
