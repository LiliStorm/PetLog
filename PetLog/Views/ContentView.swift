//
//  ContentView.swift
//  PetLog
//
//  Created by Lili Storm on 02162021--.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var pets = Pets()
    @State var showSlideOver = false
    @State var newPetName: String = ""
    @State var newPetSpecies: String = ""
    @State var newPetBreed: String = ""
    @State var newPetSliderOffset: CGFloat = UIScreen.main.bounds.height
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: PetEntity.entity(), sortDescriptors: []) var petEntities: FetchedResults<PetEntity>
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 40) {
                    
                    Text("My pets")
                        .font(.title)
                    
                    
                    List {
                        ForEach(petEntities) { pet in
                            NavigationLink(destination: PetPageView(currentPet: pet)){
                                Text(pet.name)
                                
                            }
                        }.onDelete { indexSet in
                            for index in indexSet {
                                // TODO: confirmation popup
                                viewContext.delete(petEntities[index])
                            }
                            do {
                                try viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    Button(action: {
                        showSlideOver = true
                        withAnimation(.spring()) {
                            self.newPetSliderOffset = 100
                        }
                        
                    }, label: {
                        Text("+")
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .cornerRadius(40)
                            .shadow(color: .gray, radius: 1.0)
                        
                    })
                }
                
                if(showSlideOver) {
                    NewPetView(showSlideOver: $showSlideOver, slideOverOffset: $newPetSliderOffset)
                        .offset(x: 0.0, y: newPetSliderOffset)
                }
            }.navigationBarHidden(true)
            
        }
    }
    
    func addNewPet() {
        pets.pets.append(PetModel(petName: newPetName, petSpecies: newPetSpecies, petBreed: newPetBreed))
        print("\(pets.pets.count)")
        newPetName = ""
        newPetSpecies = ""
        newPetBreed = ""
    }
}

struct PetRowView: View {
    var addedPet: PetModel
    
    var body: some View {
        HStack {
            Text(addedPet.petName)
            Text(addedPet.petSpecies)
            Text(addedPet.petBreed)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





