//
//  PetJournal+CoreDataProperties.swift
//  PetLog
//
//  Created by Lili Storm on 03012021--.
//
//

import Foundation
import CoreData


extension PetJournal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PetJournal> {
        return NSFetchRequest<PetJournal>(entityName: "PetJournal")
    }

    @NSManaged public var title: String
    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID
    @NSManaged public var petID: UUID

}

extension PetJournal : Identifiable {

}
