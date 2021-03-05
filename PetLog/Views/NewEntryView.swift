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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                TextField("Title", text: $newJournalTitle).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Content", text: $newJournalContent).textFieldStyle(RoundedBorderTextFieldStyle())
            
                Button(action: {
                    saveJournal()
                    
                }, label: {
                    Text("Save")
                        .frame(width: 70, height: 40, alignment: .center)
                        .background(isNewJournalValid() ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .cornerRadius(20)
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
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        presentationMode.wrappedValue.dismiss()
    }
}
