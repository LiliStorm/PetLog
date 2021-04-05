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
                VStack {
                    
                    Text("My pets")
                        .font(.title)
                    
                    List {
                        ForEach(petEntities) { pet in
                            NavigationLink(destination: PetPageView(currentPet: pet)){
                                ZStack(alignment: .bottom) {
                                    Image("cute piggy")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 277)
                                        //.listRowInsets(.init())
                                    
                                    Rectangle()
                                        .fill(Color.purple)
                                        .frame(width: UIScreen.main.bounds.width, height: 60)
                                        .opacity(0.6)
                                    
                                    VStack {
                                        Text(pet.name)
                                            .font(.title)
                                            .lineLimit(1)
                                            .foregroundColor(Color.white)
                                        
                                        Text(pet.birthday, style: .date)
                                            .font(.callout)
                                            .foregroundColor(Color.white)
                                    }
                                    .padding(.bottom, 5)
                                }
                                .padding(.leading, -20)
                                .padding(.top, -5)
                                .padding(.bottom, -5)
                                
                            }
                        }
                        .onDelete { indexSet in
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
                    .listStyle(PlainListStyle())
                    
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
                    Color.black
                        .ignoresSafeArea()
                        .opacity(0.5)
                    
                    NewPetView(showSlideOver: $showSlideOver, slideOverOffset: $newPetSliderOffset)
                        .cornerRadius(10)
                        .offset(x: 0.0, y: newPetSliderOffset)
                }
            }
            .navigationBarHidden(true)
            
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





