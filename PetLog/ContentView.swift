//
//  ContentView.swift
//  PetLog
//
//  Created by Lili Storm on 02162021--.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var pets = Pets()
    @State var showSlideOver = false
    @State var newPetName: String = ""
    @State var newPetSpecies: String = ""
    @State var newPetBreed: String = ""
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 40) {
                Button(action: {
                    showSlideOver = true
                    /* pets.pets.append(PetModel(petName: "Piggy", petSpecies: "Guinea Pig", petBreed: "N/A"))
                     print("\(pets.pets.count)") */
                    
                }, label: {
                    Text("+")
                        .frame(width: 60, height: 60, alignment: .center)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .cornerRadius(40)
                        .shadow(color: .gray, radius: 1.0)
                    
                })
                
                Text("My pets")
                    .font(.title)
                
                
                List() {
                    ForEach(pets.pets) { addedPet in
                        PetRowView(addedPet: addedPet)
                    } .onDelete(perform: { indexSet in
                        pets.pets.remove(atOffsets: indexSet)
                    })
                }
            }
            
            if(showSlideOver) {
                SlideOverView {
                    VStack {
                        Text("New pet")
                        TextField("Name", text: $newPetName).textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Species", text: $newPetSpecies).textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Breed", text: $newPetBreed).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("New pet")
                        
                        if(newPetName.count > 0 && newPetSpecies.count > 0 && newPetBreed.count > 0) {
                            Button(action: {
                                addNewPet()
                                
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
                }
            }
        }
    }
    
    func addNewPet() {
        pets.pets.append(PetModel(petName: newPetName, petSpecies: newPetSpecies, petBreed: "N/A"))
        print("\(pets.pets.count)")
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

struct SlideOverView<Content> : View where Content : View {
    
    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: CardView())
    }
}


struct CardView: ViewModifier {
    @State private var dragging = false
    @GestureState private var dragTracker: CGSize = CGSize.zero
    @State private var position: CGFloat = UIScreen.main.bounds.height - 100
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 2.5)
                    .frame(width: 40, height: 5.0)
                    .foregroundColor(Color.secondary)
                    .padding(10)
                content.padding(.top, 30)
            }
            .frame(minWidth: UIScreen.main.bounds.width)
            .scaleEffect(x: 1, y: 1, anchor: .center)
            .background(Color.white)
            .cornerRadius(15)
        }
        .offset(y:  max(0, position + self.dragTracker.height))
        .animation(dragging ? nil : {
            Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)
        }())
        .gesture(DragGesture()
                    .updating($dragTracker) { drag, state, transaction in state = drag.translation }
                    .onChanged {_ in  dragging = true }
                    .onEnded(onDragEnded))
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        dragging = false
        let high = UIScreen.main.bounds.height - 100
        let low: CGFloat = 100
        let dragDirection = drag.predictedEndLocation.y - drag.location.y
        //can also calculate drag offset to make it more rigid to shrink and expand
        if dragDirection > 0 {
            position = high
        } else {
            position = low
        }
    }
}

struct SlideOverView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
