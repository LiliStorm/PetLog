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
    @State var entryDate: Date = Date()
    @ObservedObject var fetchedJournal: PetJournal
    @State var isEditing = false
    
    var body: some View {
        VStack {
            if !isEditing {
                Text(entryTitle)
                    .font(Font.title.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                HStack {
                    Text(entryDate, style: .date)
                        .font(Font.subheadline.weight(.light))
                    Text(entryDate, style: .time)
                        .font(Font.subheadline.weight(.light))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                ScrollView {
                    Text(entryContent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.body.weight(.light))
                        .lineLimit(nil)
                        .padding()
                }
                
                Button(action: {
                    isEditing.toggle()
                }, label: {
                    Text("Edit")
                        .frame(width: 60, height: 30, alignment: .center)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 1.0)
                })
                
            } else { // isEditing == true
                
                DatePicker("Date:", selection: $entryDate, in: ...Date())
                    .padding()
                
                TextField("Title", text: $entryTitle).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextEditor(text: $entryContent)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 400)
                    .border(Color.gray.opacity(0.2))
                
                Button(action: {
                    saveChanges()
                    isEditing.toggle()
                }, label: {
                    Text("Save")
                        .frame(width: 60, height: 30, alignment: .center)
                        .background(isJournalChangeValid() ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 1.0)
                })
                .disabled(!isJournalChangeValid())
            }
            
            Spacer()
        }.onAppear {
            setInitialValues()
        }
    }
    
    func setInitialValues() {
        entryTitle = fetchedJournal.title
        entryContent = fetchedJournal.content!
        entryDate = fetchedJournal.date
    }
    
    func saveChanges() {
        fetchedJournal.title = entryTitle
        fetchedJournal.content = entryContent
        fetchedJournal.date = entryDate
        try? fetchedJournal.managedObjectContext?.save()
    }
    
    func isJournalChangeValid() -> Bool {
        if (entryTitle.isEmpty) {
            return false
        }
        return true
    }
}
