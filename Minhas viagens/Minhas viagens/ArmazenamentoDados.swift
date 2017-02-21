//
//  ArmazenamentoDados.swift
//  Minhas viagens
//
//  Created by Dev12 on 21/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class ArmazenamentoDados {
    let chaveArmazenamento = "locaisViagem"
    var viagens: [Dictionary<String,String>] = []
    
    func getDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
    
    func salvarViagem(viagem: Dictionary<String,String>) {
        
        // Recupera as viagens para não sobrescrever as viagens antigas toda vez que uma nova for salva
        viagens = listarViagens()
        
        viagens.append(viagem)
        getDefaults().set(viagens, forKey: chaveArmazenamento)
        
        // Método responsável por forçar o salvamento das viagens no dispositivo devido ao fato de que o salvamento pelo UserDefaults demora um certo tempo
        getDefaults().synchronize()
    }
    
    func listarViagens() -> [Dictionary<String,String>] {
        let dados = getDefaults().object(forKey: chaveArmazenamento)
        if dados != nil {
            return dados as! Array
        }else {
            return []
        }
    }
    
    func removerViagem(index: Int) {
        // Recupera as viagens
        viagens = self.listarViagens()
        viagens.remove(at: index)
        
        // Salvar Tarefas
        getDefaults().set(viagens, forKey: chaveArmazenamento)
        getDefaults().synchronize()
    }
}
