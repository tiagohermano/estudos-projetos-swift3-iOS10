//
//  ViewController.swift
//  Onde estou
//
//  Created by Tiago Hermano on 19/02/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
    }
    
    // Caso a permissao de localizacao seja negada, usado este tratamento.
    // Que exibe um alerta com duas acoes: Abrir tela de configuracoes do iPhone e Cancelar.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            var alertController = UIAlertController(title: "Permissao de localizacao", message: "Necessário permissao para acesso a sua localizacao! Por favor Habilite.", preferredStyle: .alert)
            
            //
            var acaoConfiguracoes = UIAlertAction(title: "Abrir Configuracoes", style: .default, handler: {(alertaConfiguracoes) in
                if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open( configuracoes as URL)
                }
            })
            
            var acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

