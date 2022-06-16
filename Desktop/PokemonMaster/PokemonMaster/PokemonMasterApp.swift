//
//  PokemonMasterApp.swift
//  PokemonMaster
//
//  Created by Test on 15/6/22.
//

import SwiftUI

@main
struct PokemonMasterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    PokeAPIService.shared.getPokemons { response in
                        print(response)
                    }
                }
        }
    }
}
