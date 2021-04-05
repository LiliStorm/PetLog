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
            
            HStack {
                Image("cute piggy")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(currentPet.name)
                        .font(.title)
                    
                    Text(currentPet.birthday, style: .date)
                        .font(.callout)
                    
                    HStack {
                        Text(currentPet.species ?? "(unspecified species)")
                        Text(" - ")
                        Text(currentPet.breed ?? "(unspecified breed)")
                    }
                    
                }
                
                Spacer()
            }
            .padding()
            
            List() {
                ForEach(journalEntries) { journal in
                    if (journal.petID == currentPet.id) {
                        NavigationLink(destination: JournalEntryView(fetchedJournal: journal)) {
                            VStack(alignment: .leading) {
                                
                                Text(journal.title)
                                    .font(Font.headline.weight(.semibold))
                                
                                HStack {
                                    Text(journal.date, style: .date)
                                        .font(Font.subheadline.weight(.light))
                                    Text(journal.date, style: .time)
                                        .font(Font.subheadline.weight(.light))
                                }
                                
                                Text(contentTextPreview(fullContentText: journal.content))
                                    .font(Font.callout.weight(.regular))
                                    .padding(.top, 10)
                            }
                        }
                        .padding(5)
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
    
    func contentTextPreview(fullContentText: String?) -> String {
        if (fullContentText == nil) {
            return "No content for this journal"
        }
        if (fullContentText!.count > 77) {
            return fullContentText!.prefix(77) + "..."
        }
        return fullContentText!
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
