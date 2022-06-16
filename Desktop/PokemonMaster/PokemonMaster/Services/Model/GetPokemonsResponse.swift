//
//  GetPokemonsResponse.swift
//  PokemonMaster
//
//  Created by Johann Fong on 7/6/22.
//

import Foundation

struct GetPokemonsResponse: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
    
    struct Pokemon: Codable {
        let name: String
        let url: String
    }
}

extension GetPokemonsResponse.Pokemon {
    var pokemonID: String {
        URL(string: url)?.lastPathComponent ?? ""
    }
}
