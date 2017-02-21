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
    var viagem: Dictionary<String, String> = [:]
    var indiceSelecionado: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let indice = indiceSelecionado {
            if indice == -1 {
                configuraGerenciadorLocalizacao()
            } else {
                // listar
                self.exibirAnotacao(viagem: viagem)
            }
        }
        
        // UILongPressGestureRecognizer: classe responsável identificar toques com maior duração na tela e executar uma determinada ação
        let reconhecedorGesto = UILongPressGestureRecognizer(target: self, action: #selector( ViewController.marcar(gesture:) ))
        // Acesso ao atributo que define o tempo de duração mínima do toque
        reconhecedorGesto.minimumPressDuration = 1
        mapa.addGestureRecognizer(reconhecedorGesto)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let local = locations.last!
        
        // Exibe local
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(local.coordinate.latitude, local.coordinate.longitude)
        
        // Zoom visualização do mapa
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        
        // Monta Exibição do mapa
        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        self.mapa.setRegion(regiao, animated: true)
    }
    
    func exibirLocal(latitude: Double, longitude: Double) {
        // Exibe local
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        // Zoom visualização do mapa
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        // Monta Exibição do mapa
        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        self.mapa.setRegion(regiao, animated: true)
    }
    
    func exibirAnotacao(viagem: Dictionary<String,String>) {
        // Exibe anotação com os dados de endereço
        if let localViagem = viagem["local"] {
            if let latitudeS = viagem["latitude"] {
                if let longitudeS = viagem["longitude"] {
                    if let latitude = Double(latitudeS) {
                        if let longitude = Double(longitudeS) {
                            // Recupera latitude e longitude e define titulo e subtitulo para a anotação
                            let anotacao = MKPointAnnotation()
                            anotacao.coordinate.latitude = latitude
                            anotacao.coordinate.longitude = longitude
                            
                            anotacao.title = localViagem
                            
                            self.mapa.addAnnotation(anotacao)
                            
                            self.exibirLocal(latitude: latitude, longitude: longitude)
                        }
                    }
                }
            }
        }
    }
    
    func marcar(gesture:UIGestureRecognizer) {
        
        // Captura o estado do gesture apenas quando ele é iniciado, evitando de que ele seja clicado mais de uma vez
        if gesture.state == UIGestureRecognizerState.began {
            
            // Recupera as coordenadas do ponto selecionado
            let pontoSelecionado = gesture.location(in: self.mapa)
            let coordenadas = mapa.convert(pontoSelecionado, toCoordinateFrom: self.mapa)
            let localizacao = CLLocation(latitude: coordenadas.latitude, longitude: coordenadas.longitude)
            
            // Recupera endereço de um ponto selecionado
            var localCompleto = "Endereço não encontrado :("
            CLGeocoder().reverseGeocodeLocation(localizacao, completionHandler: { (local, erro) in
                if erro == nil {
                    // Valida e verifica se o local selecionado tem um Nome principal, se não tiver é atribuido ao titulo da anotação o nome da rua, ou segunda informação sobre a localização
                    if let dadosLocal = local?.first {
                        if let nome = dadosLocal.name {
                            localCompleto = nome
                        } else {
                            if let endereco = dadosLocal.thoroughfare {
                                localCompleto = endereco
                            }
                        }
                    }
                    
                    // Salvar Dados no dispositivo
                    self.viagem = ["local":localCompleto, "latitude":String(coordenadas.latitude), "longitude":String(coordenadas.longitude)]
                    ArmazenamentoDados().salvarViagem(viagem: self.viagem)
                    
                    self.exibirAnotacao(viagem: self.viagem)
                    
                } else {
                    print(erro)
                }
            
            })
            
            
        }
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

