//
//  PetPageView.swift
//  PetLog
//
//  Created by Lili Storm on 02212021--.
//

import SwiftUI

struct PetPageView: View {
    
    @ObservedObject var entries = Journal()
    @State var showSlideOver = false
    
    var body: some View {
       //  NavigationView {
        Text("This is your pet's page!")
            VStack(spacing: 40) {
            Button(action: {
                showSlideOver = true
                print($showSlideOver)
                
            }, label: {
                Text("+")
                    .frame(width: 60, height: 60, alignment: .center)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .cornerRadius(40)
                    .shadow(color: .gray, radius: 1.0)
                
            })
            
                List() {
                    ForEach(entries.journal) { entry in
                            // NavigationLink(destination: PetPageView()) {
                                EntryRowView(entry: entry)
                        // }
                        } .onDelete(perform: { indexSet in
                            entries.journal.remove(atOffsets: indexSet)
                        })
                    }
                }
    // }
    }
}

struct PetPageView_Previews: PreviewProvider {
    static var previews: some View {
        PetPageView()
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
