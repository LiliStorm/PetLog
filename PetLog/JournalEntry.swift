//
//  JournalEntry.swift
//  PetLog
//
//  Created by Lili Storm on 02192021--.
//

import Foundation

struct JournalEntry: Identifiable {
    var id = UUID()
    var headline: String
    var content: String
    // var date: Date
}
