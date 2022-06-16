//
//  PokemonListView.swift
//  PokemonMaster
//
//  Created by Johann Fong on 7/6/22.
//

import SwiftUI

struct PokemonListView: View {
    @State var searchText = ""
    @State var pokemons: [GetPokemonsResponse.Pokemon] = []
    
    var filteredPokemons: [GetPokemonsResponse.Pokemon]{
        guard !searchText.isEmpty else { return pokemons
        }
        return pokemons.filter {
            pokemon in pokemon.name.lowercased().contains(searchText.lowercased())
        }
        
        
    
    
    var body: some View {
        List(filteredPokemons, id: \.pokemonID) { pokemon in
            NavigationLink(
                destination: PokemonDetailsView(id: pokemon.pokemonID)
            ) {
                HStack(alignment: .center, spacing: 24) {
                    AsyncImage(
                        url: PokeAPIService.shared.getPokemonSprites(id: pokemon.pokemonID)
                    )
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .foregroundColor(.gray.opacity(0.6))
                    Text(pokemon.name.capitalized)
                        .font(.headline)
                }
            }
        }
        .onAppear {
            PokeAPIService.shared.getPokemons { response in
                pokemons = response.results
            }
        }
        .navigationTitle("Pokédex")
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
