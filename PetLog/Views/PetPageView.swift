//
//  PetPageView.swift
//  PetLog
//
//  Created by Lili Storm on 02212021--.
//

import SwiftUI

struct PetPageView: View {
    
    //@ObservedObject var entries = Journal()
    @State var showNewJournalSlideOver = false
    @State var newJournalSliderOffset: CGFloat = UIScreen.main.bounds.height
    //var currentPetID: UUID
    var currentPet: PetEntity
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: PetJournal.entity(), sortDescriptors: []) var journalEntries: FetchedResults<PetJournal>
    
    var body: some View {
        VStack(spacing: 40) {
            ZStack {
                Image("cute piggy")
                    .resizable()
                    .scaledToFill()
                
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill(Color.purple)
                            .frame(width: UIScreen.main.bounds.width, height: 40)
                            .opacity(0.6)
                        
                        Text(currentPet.name)
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                }
            }
            
            List() {
                ForEach(journalEntries) { entry in
                    if (entry.petID == currentPet.id) {
                        NavigationLink(destination: JournalEntryView(fetchedJournal: entry)) {
                            Text(entry.title)
                        }
                    }
                } .onDelete { indexSet in
                    for index in indexSet {
                        // TODO: confirmation popup
                        viewContext.delete(journalEntries[index])
                    }
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            NavigationLink(destination: NewEntryView(currentPet: currentPet)) {
                Text("+")
                    .frame(width: 60, height: 60, alignment: .center)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .cornerRadius(40)
                    .shadow(color: .gray, radius: 1.0)
            }
            
        }
        
        //makes the navigation header small and sort of hidden, but keeps the "back" button visible
        .navigationBarTitle("", displayMode: .inline)
    }
    
}

struct EntryRowView: View {
    var entry: JournalEntry
    
    var body: some View {
        HStack {
            Text(entry.headline)
            Text(entry.content)
        }
    }
    
}
