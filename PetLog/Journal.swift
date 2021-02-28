//
//  Journal.swift
//  PetLog
//
//  Created by Lili Storm on 02192021--.
//

import Foundation

class Journal: ObservableObject {
    @Published var journal = [JournalEntry]()
    
    init() {
        addModelData()
    }
    
    func addModelData() {
        journal.append(JournalEntry(headline: "Thursday", content: "What a lovely day!"))
        journal.append(JournalEntry(headline: "Friday", content: "What a perfectly splendid day!"))
    }
}
