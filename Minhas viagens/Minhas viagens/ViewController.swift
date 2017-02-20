//
//  ViewController.swift
//  Minhas viagens
//
//  Created by Dev12 on 20/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraGerenciadorLocalizacao()
    }
    
    func configuraGerenciadorLocalizacao() {
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
    }
    
    // Função para caso acesso à localização seja negada pelo usuário
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            // Criação de alert
            let alertController = UIAlertController(title: "Permissão de localização", message: "Necessária permissão para acesso a sua localização! Por favor habilite", preferredStyle: .alert)
            
            // Criação de botão do alert que redireciona para a tela de configurações do dispositivo
            let acaoConfiguracoes = UIAlertAction(title: "Abrir Configurações", style: .default, handler: { (alertaConfiguracoes) in
                if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.open(configuracoes as URL)
                }
            })
            // Criação do botão de cancelemento do alert
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            // Adição das ações ao alert
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            // Apresentação do alert na tela
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

