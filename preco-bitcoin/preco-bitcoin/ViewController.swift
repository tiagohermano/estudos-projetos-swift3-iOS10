//
//  ViewController.swift
//  preco-bitcoin
//
//  Created by iDev on 10/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var precoBitcoin: UILabel!
    @IBOutlet weak var botaoAtualizar: UIButton!

    @IBAction func atualizarPreco(_ sender: Any) {
        self.recuperPrecoBitcoin()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recuperPrecoBitcoin()
        
    }
    
    func formatarPreco(preco: NSNumber) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco) {
            return precoFinal
        }
        
        return "0,00"
    }
    
    func recuperPrecoBitcoin() {
        
        self.botaoAtualizar.setTitle("Atualizando...", for: .normal)
        if let url = URL(string: "https://blockchain.info/pt/ticker") {
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                if erro == nil {
                    
                    if let dadosRetorno = dados {
                        
                        do {
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String:Any] {
                                
                                if let brl = objetoJson["BRL"] as? [String:Any]{
                                    if let preco = brl["buy"] as? Float {
                                        let precoFormatado = self.formatarPreco(preco: NSNumber(value: preco))
                                        
                                        self.botaoAtualizar.setTitle("Atualizar", for: .normal)
                                        self.precoBitcoin.text = "R$ " + precoFormatado
                                    }
                                }
                                
                            }
                            
                        } catch {
                            print("Erro ao formatar o retorno")
                        }
                    }
                    
                } else {
                    print("Erro ao fazer requisição")
                }
            }
            tarefa.resume()
        }
    }

}

