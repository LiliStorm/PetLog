//
//  PetModel.swift
//  PetLog
//
//  Created by Lili Storm on 02162021--.
//

import Foundation

struct PetModel: Identifiable {
    var id = UUID()
    var petName: String
    var petSpecies: String
    var petBreed: String
}
