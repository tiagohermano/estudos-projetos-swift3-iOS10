//
//  Map.swift
//  Mapa-UFG
//
//  Created by tulio ferreira hermano on 21/05/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class Map: UIViewController {
    
    static func setMap() -> UIView {
        //        let API_KEY = "AIzaSyBnBZnGiD6uQqKy2ydjMX53dU7ebTS1Xi0"
        
//        navigationItem.title = "Mapa-UFG"
        
        // -16.6021102,-49.2656253
        
        let camera = GMSCameraPosition.camera(withLatitude: -16.6021102, longitude: -49.2656253, zoom: 16)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        
        let marker = GMSMarker()
        marker.title = "UFG"
        marker.position = camera.target
        marker.snippet = "Universidade Federal de Goiás"
        marker.appearAnimation = .pop
        marker.map = mapView
        
        return mapView
    }
    
    func setMarkers(categoria: String) {
        switch categoria {
            case "Lanconetes": break
                // CRIAR MARCADORES DE LANCONETES
        default:
            break
        }
    }
}
