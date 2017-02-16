//
//  ViewController.swift
//  Trabalhando com mapas
//
//  Created by Dev12 on 16/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude: CLLocationDegrees = -16.680588
        let longitude: CLLocationDegrees = -49.256327
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        // Latitude e longitude delta: Zoom do mapa
        let deltaLatitude: CLLocationDegrees = 0.08
        let deltaLongitude: CLLocationDegrees = 0.08
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        mapa.setRegion(regiao, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

