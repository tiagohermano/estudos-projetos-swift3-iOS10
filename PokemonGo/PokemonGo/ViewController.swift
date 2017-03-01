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
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Esta própria classe vai gerenciar o objeto mapa pois ela já herda da classe MKMapViewDelegate
        mapa.delegate = self
        
        // Esta própria classe vai gerenciar o objeto gerenciadorLocalizacção pois ela já herda da classe CLLocationManagerDelegate
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        // Recuperar Pokemons
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recuperarTodosPokemons()
        
        // Exibir Pokémons
        // Cria anotações no mapa com as coordenadas do usuário em um intervalo determinado
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate {
                
                let totalPokemons = UInt32(self.pokemons.count)
                let indicePokemonAleatorio = arc4random_uniform(totalPokemons)
                
                let pokemon = self.pokemons[Int(indicePokemonAleatorio)]
                
                let anotacao = PokemonAnotacao(coordenadas: coordenadas, pokemon: pokemon)
                
                let latAleatoria = (Double(arc4random_uniform(400)) - 200) / 100000.0
                let longAleatoria = (Double(arc4random_uniform(400)) - 200) / 100000.0
                
                anotacao.coordinate.latitude  += latAleatoria
                anotacao.coordinate.longitude += longAleatoria
                
                self.mapa.addAnnotation(anotacao)
            }
            
        }
        
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
    
    // Método chamado sempre que uma anotação é criada
    // Monta uma nova visualização para as anotações
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        // Define uma imagem para a anotação do localização do usuário e outra para as anotações geradas
        if annotation is MKUserLocation {
            anotacaoView.image = #imageLiteral(resourceName: "player")
        } else {
            let pokemon = (annotation as! PokemonAnotacao).pokemon
            anotacaoView.image = UIImage(named: pokemon.nomeImagem!)
        }
        
        // Redefinindo o tamanho do frame da anotação(imagem)
        var frame = anotacaoView.frame
        frame.size.height = 40
        frame.size.width  = 40
        anotacaoView.frame = frame
        
        return anotacaoView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let anotacao = view.annotation
        let pokemon = (anotacao as! PokemonAnotacao).pokemon
        
        mapView.deselectAnnotation(anotacao, animated: true)
        
        if anotacao is MKUserLocation {
            return
        }
        
        // Centralizar na tela o Pokemon selecionado
        if let coordAnotacao = anotacao?.coordinate {
            let regiao = MKCoordinateRegionMakeWithDistance(coordAnotacao, 200, 200)
            self.mapa.setRegion(regiao, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            if let coord = self.gerenciadorLocalizacao.location?.coordinate {
                if MKMapRectContainsPoint(self.mapa.visibleMapRect, MKMapPointForCoordinate(coord)) {
                    self.coreDataPokemon.salvarPokemon(pokemon: pokemon)
                    self.mapa.removeAnnotation(anotacao!)
                    
                    let alertController = UIAlertController(title: "Capturado!", message: "Você capturou o \(pokemon.nome!) ", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(ok)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    
                    let alertController = UIAlertController(title: "Não Capturado!", message: "Você está muito longe do \(pokemon.nome!) para captura-lo", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(ok)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        self.coreDataPokemon.salvarPokemon(pokemon: pokemon)
        
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

