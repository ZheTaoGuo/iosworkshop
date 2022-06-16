//
//  ContentView.swift
//  PokemonMaster
//
//  Created by Johann Fong on 7/6/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PokemonListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
