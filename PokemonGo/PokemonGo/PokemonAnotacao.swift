//
//  PokemonAnotacao.swift
//  PokemonGo
//
//  Created by Tiago Hermano on 3/1/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import MapKit

// A classe MKAnnotation requer a herança da classe NSObject para que uma outra classe herde dela
class PokemonAnotacao: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coordenadas: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
    }
}
