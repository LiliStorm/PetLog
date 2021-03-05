//
//  NewJournalView.swift
//  PetLog
//
//  Created by Lili Storm on 03012021--.
//

import SwiftUI

struct JournalPageView: View {
    
    var currentPet: PetEntity
    
    @State var newJournalTitle: String = ""
    @State var newJournalContent: String = ""
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: PetJournal.entity(), sortDescriptors: []) var journalEntries: FetchedResults<PetJournal>
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                TextField("Title", text: $newJournalTitle).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Content", text: $newJournalContent).textFieldStyle(RoundedBorderTextFieldStyle())
            
                Button(action: {
                    //addNewPet()
                    
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
        .navigationBarTitle("Journal", displayMode: .inline)
    }
    
    func isNewJournalValid() -> Bool {
        if (newJournalTitle.isEmpty) {
            return false
        }
        return true
    }
}
