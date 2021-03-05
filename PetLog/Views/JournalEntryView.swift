//
//  JournalEntryPageView.swift
//  PetLog
//
//  Created by Lili Storm on 03032021--.
//

import SwiftUI

struct JournalEntryView: View {
    /* @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: PetJournal.entity(), sortDescriptors: []) var journalEntries: FetchedResults<PetJournal>
    var currentJournalID: UUID */
    @State var entryTitle: String = ""
    @State var entryContent: String = ""
    @ObservedObject var fetchedJournal: PetJournal
    @State var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if !isEditing {
                Text(entryTitle)
                Text(entryContent)
                Button("Edit") {
                    isEditing.toggle()
                }
            } else {
                Text("Title:")
                TextEditor(text: $entryTitle)
                    .frame(width: nil, height: 90)
                Text("Entry content")
                TextEditor(text: $entryContent)
                    .frame(width: nil, height: 90)
                Button("Save") {
                    saveChanges()
                    isEditing.toggle()
                }
            }
            
            Spacer()
        }.onAppear {
            // fetchedJournal = journalEntries.first(where: { $0.id == currentJournalID})!
            setInitialValues()
        }

    }
    func setInitialValues() {
        entryTitle = fetchedJournal.title
        entryContent = fetchedJournal.content!
    }
    
    func saveChanges() {
        fetchedJournal.title = entryTitle
        fetchedJournal.content = entryContent
        try? fetchedJournal.managedObjectContext?.save()
    }
}
