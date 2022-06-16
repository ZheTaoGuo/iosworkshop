//
//  PokemonDetailsView.swift
//  PokemonMaster
//
//  Created by Johann Fong on 8/6/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    var id: String
    @State var model: PokemonDetailsModel?
    
    var body: some View {
        VStack {
            if let model = model {
                VStack(alignment: .center, spacing: 24) {
                    AsyncImage(url: PokeAPIService.shared.getPokemonOfficialArtwork(id: id)
                    ) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 240, height: 240)
                    Text(model.name.capitalized)
                        .font(.title)
                    HStack {
                        Text("Height: \(model.height)")
                        Text("Weight: \(model.weight)")
                    }
                    List {
                        Section(header: Text("Abilities")) {
                            ForEach(model.abilities, id: \.self) { ability in
                                Text(ability)
                            }
                        }
                        Section(header: Text("Stats")) {
                            ForEach(model.stats, id: \.name) { stat in
                                HStack {
                                    Text(stat.name)
                                    Spacer()
                                    Text(stat.value)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            PokeAPIService.shared.getPokemons(by: id) { response in
                model = parse(response: response)
            }
        }
    }
    
    func parse(response: GetPokemonResponse) -> PokemonDetailsModel? {
        guard
            let name = response.name,
            let height = response.height,
            let weight = response.weight,
            let abilities = response.abilities,
            let stats = response.stats
        else {
            return nil
        }
        return PokemonDetailsModel(
            name: name,
            height: String(height),
            weight: String(weight),
            abilities: abilities.compactMap {
                guard let name = $0.ability?.name else { return nil }
                return name
            },
            stats: stats.compactMap {
                guard
                    let name = $0.stat?.name,
                    let value = $0.baseStat
                else { return nil }
                return .init(name: name, value: String(value))
            }
        )
        
    }
    
    struct PokemonDetailsModel {
        var name: String
        var height: String
        var weight: String
        var abilities: [String]
        var stats: [Stat]
        
        struct Stat {
            var name: String
            var value: String
        }
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var mockModel: PokemonDetailsView.PokemonDetailsModel = .init(
        name: "charmander",
        height: "6",
        weight: "85",
        abilities: [
            "blaze", "solar-power"
        ],
        stats: [
            .init(name: "hp", value: "39"),
            .init(name: "attack", value: "52"),
            .init(name: "defense", value: "43"),
            .init(name: "special-attack", value: "60"),
            .init(name: "special-defense", value: "50"),
            .init(name: "speed", value: "65")
        ]
    )
    
    static var previews: some View {
        PokemonDetailsView(id: "4", model: mockModel)
    }
}
