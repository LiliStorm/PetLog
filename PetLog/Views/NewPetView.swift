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
    @State var newPetBirthday = Date()
    
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
                DatePicker("Birthday", selection: $newPetBirthday, in: ...Date(), displayedComponents: .date)
                
                HStack {
                    Button(action: {
                        hideView()
                    }, label: {
                        Text("Cancel")
                            .frame(width: 80, height: 30, alignment: .center)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 1.0)
                    })
                    
                    Button(action: {
                        addNewPet()
                        hideView()
                        
                    }, label: {
                        Text("Add")
                            .frame(width: 60, height: 30, alignment: .center)
                            .background(isNewPetValid() ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 1.0)
                    })
                    .disabled(!isNewPetValid())
                }
                .padding()
                
                Spacer()
            }
            .padding()
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
        newPet.birthday = newPetBirthday
        //newPet.age = 1
        newPet.id = UUID()
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func hideView() {
        newPetName = ""
        newPetSpecies = ""
        newPetBreed = ""
        withAnimation(.spring()) {
            slideOverOffset = UIScreen.main.bounds.height
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showSlideOver = false
            }
        }
    }
}
