//
//  NewJournalView.swift
//  PetLog
//
//  Created by Lili Storm on 03012021--.
//

import SwiftUI

struct NewEntryView: View {
    
    var currentPet: PetEntity
    
    @State var newJournalTitle: String = ""
    @State var newJournalContent: String = ""
    @State var newJournalDate: Date = Date()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                
                DatePicker("Date:", selection: $newJournalDate, in: ...Date())
                    .padding()
                
                TextField("Title", text: $newJournalTitle).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextEditor(text: $newJournalContent)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 400)
                    .border(Color.gray.opacity(0.2))
            
                Button(action: {
                    saveJournal()
                }, label: {
                    Text("Add")
                        .frame(width: 60, height: 30, alignment: .center)
                        .background(isNewJournalValid() ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 1.0)
                })
                .disabled(!isNewJournalValid())
                
                Spacer()
            }
        }
        .navigationBarTitle("New post", displayMode: .inline)
    }
    
    func isNewJournalValid() -> Bool {
        if (newJournalTitle.isEmpty) {
            return false
        }
        return true
    }
    
    func saveJournal() {
        let newJournal = PetJournal(context: viewContext)
        newJournal.petID = currentPet.id
        newJournal.id = UUID()
        newJournal.title = newJournalTitle
        newJournal.content = newJournalContent
        newJournal.date = newJournalDate
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        presentationMode.wrappedValue.dismiss()
    }
}
