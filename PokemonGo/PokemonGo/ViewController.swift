//
//  ViewController.swift
//  PokemonGo
//
//  Created by Tiago Hermano on 2/24/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var contador = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Esta própria classe vai gerenciar o objeto mapa pois ela já herda da classe MKMapViewDelegate
        mapa.delegate = self
        
        // Esta própria classe vai gerenciar o objeto gerenciadorLocalizacção pois ela já herda da classe CLLocationManagerDelegate
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        
    }
    
    // Método responsável por centralizar a tela na localização do usuário no mapa
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if contador < 3 {
            self.centralizar()
            contador += 1
        } else {
            gerenciadorLocalizacao.stopUpdatingLocation()
        }
    }
    
    // Método para caso o acesso à localização seja negada
    // Este método é chamado toda vez que a permissão de localização é alterada
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .notDetermined {
            // Criação de alert
            let alertController = UIAlertController(title: "Permissão de Localização", message: "Necessária permissão para acesso a sua localização. Por favor Habilite", preferredStyle: .alert)
            
            // Criação do botão do alert que redireciona o usuário para as configurações do sistema
            let acaoConfiguracoes = UIAlertAction(title: "Abrir Configurações", style: .default, handler: { (alertaConfiguracoes) in
                if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(configuracoes as URL)
                }
            })
            
            // Criação do botão cancelamento do alert
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            // Vinculação dos botões ao alert criado
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
    
    func centralizar() {
        if let coordenadas = gerenciadorLocalizacao.location?.coordinate {
            let regiao = MKCoordinateRegionMakeWithDistance(coordenadas, 200, 200)
            self.mapa.setRegion(regiao, animated: true)
        }
    }

    @IBAction func centralizarJogador(_ sender: Any) {
        self.centralizar()
    }

    @IBAction func abrirPokedex(_ sender: Any) {
    }
}

