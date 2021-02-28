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
                            Text(pet.name)
                        }.onDelete { indexSet in
                            for index in indexSet {
                                // TODO: maybe a confirmation pop-up could be nice here?
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
                        //showSlideOver = true
                        /*let newPet = PetEntity(context: viewContext)
                         newPet.name = "Poseidon"
                         newPet.species = "Rat"
                         newPet.breed = "Domesticated rat"
                         newPet.age = 1
                         newPet.id = UUID()
                         do {
                         try viewContext.save()
                         } catch {
                         print(error.localizedDescription)
                         }
                         
                         // testy test test woop woop
                         if let updatedPet = petEntities.first(where: { $0.id == newPet.id }) {
                         viewContext.performAndWait {
                         // updatedPet.name = "Poseidon von Råtta"
                         do {
                         try viewContext.save()
                         } catch {
                         print(error.localizedDescription)
                         }
                         }
                         }
                         
                         print(petEntities) */
                        
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
                    /*SlideOverView {
                     VStack {
                     Text("New pet")
                     TextField("Name", text: $newPetName).textFieldStyle(RoundedBorderTextFieldStyle())
                     TextField("Species", text: $newPetSpecies).textFieldStyle(RoundedBorderTextFieldStyle())
                     TextField("Breed", text: $newPetBreed).textFieldStyle(RoundedBorderTextFieldStyle())
                     //Text("New pet")
                     
                     if(newPetName.count > 0 && newPetSpecies.count > 0 && newPetBreed.count > 0) {
                     Button(action: {
                     addNewPet()
                     showSlideOver = false
                     
                     }, label: {
                     Text("Save")
                     .frame(width: 60, height: 60, alignment: .center)
                     .background(Color.orange)
                     .foregroundColor(.white)
                     .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                     .cornerRadius(40)
                     .shadow(color: .gray, radius: 1.0)
                     
                     })
                     }
                     
                     Spacer()
                     }
                     }*/
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





