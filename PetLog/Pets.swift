//
//  Pets.swift
//  PetLog
//
//  Created by Lili Storm on 02162021--.
//

import Foundation

class Pets {
    var pets = [PetModel]()
    
    init() {
        addMockData()
    }
    
    func addMockData() {
        pets.append(PetModel(petName: "Doggo", petSpecies: "Dog", petBreed: "Pointer"))
        pets.append(PetModel(petName: "Kitty", petSpecies: "Cat", petBreed: "Persian"))
        pets.append(PetModel(petName: "Ratty", petSpecies: "Rat", petBreed: "Domesticated rat"))
        pets.append(PetModel(petName: "Hammy", petSpecies: "Hamster", petBreed: "Pointer"))
    }
}
