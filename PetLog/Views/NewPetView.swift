//
//  NewPetView.swift
//  PetLog
//
//  Created by Lili Storm on 02282021--.
//

import SwiftUI

struct NewPetView: View {
    
    @Binding var showSlideOver: Bool
    @Binding var slideOverOffset: CGFloat
    
    @State var newPetName: String = ""
    @State var newPetSpecies: String = ""
    @State var newPetBreed: String = ""
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: PetEntity.entity(), sortDescriptors: []) var petEntities: FetchedResults<PetEntity>
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Text("New pet")
                    .font(.title)
                TextField("Name", text: $newPetName).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Species", text: $newPetSpecies).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Breed", text: $newPetBreed).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    addNewPet()
                    
                }, label: {
                    Text("Save")
                        .frame(width: 60, height: 60, alignment: .center)
                        .background(isNewPetValid() ? Color.orange : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .cornerRadius(40)
                        .shadow(color: .gray, radius: 1.0)
                })
                .disabled(!isNewPetValid())
                
                Spacer()
            }
        }
        
    }
    
    func isNewPetValid() -> Bool {
        if (newPetName.isEmpty) {
            return false
        }
        return true
    }
    
    func addNewPet() {
        let newPet = PetEntity(context: viewContext)
        newPet.name = newPetName
        newPet.species = newPetSpecies
        newPet.breed = newPetBreed
        //newPet.age = 1
        newPet.id = UUID()
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
        newPetName = ""
        newPetSpecies = ""
        newPetBreed = ""
        withAnimation(.spring()) {
            //showSlideOver = false
            slideOverOffset = UIScreen.main.bounds.height
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showSlideOver = false
            }
        }
    }
}
