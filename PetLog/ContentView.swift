//
//  ContentView.swift
//  PetLog
//
//  Created by Lili Storm on 02162021--.
//

import SwiftUI

struct ContentView: View {
    
    var pets = Pets()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
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
