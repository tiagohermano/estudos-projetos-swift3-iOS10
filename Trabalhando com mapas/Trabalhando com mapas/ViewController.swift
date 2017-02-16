//
//  ViewController.swift
//  Trabalhando com mapas
//
//  Created by Dev12 on 16/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocal = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Metodo responsavel por definir a classe que delegara o gerenciadorLocal
        gerenciadorLocal.delegate = self
        
        // Metodo resposavel por definir a precisao do GP(No caso: Melhor Precisao)
        gerenciadorLocal.desiredAccuracy = kCLLocationAccuracyBest
        
        // Metodo responsavel por pedir autorizacao para acessar a localizacao do dispositivo
        gerenciadorLocal.requestWhenInUseAuthorization()
        
        // Metodo responsavel por atualizar a localizacao do dispositivo
        gerenciadorLocal.startUpdatingLocation()
        
        /*let latitude: CLLocationDegrees = -16.680588
        let longitude: CLLocationDegrees = -49.256327
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        // Latitude e longitude delta: Zoom do mapa
        let deltaLatitude: CLLocationDegrees = 0.08
        let deltaLongitude: CLLocationDegrees = 0.08
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        
        mapa.setRegion(regiao, animated: true)
        
        // Configurando Anotação no mapa (Marcador)
        let anotacao = MKPointAnnotation()
        anotacao.coordinate = localizacao // ou anotacao.coordinate.latitude = ... / anotacao.coordinate.longitude = ...
        anotacao.title = "Praça Cívica"
        anotacao.subtitle = "Praça localizada no centro da cidade de Goiânia"
        
        mapa.addAnnotation(anotacao)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

