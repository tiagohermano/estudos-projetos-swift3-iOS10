//
//  TarefaUserDefaults.swift
//  Lista tarefas
//
//  Created by Dev12 on 16/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class TarefaUserDefaults {
    
    let chaveListaTarefa = "listaTarefa"
    var tarefas: [String] = []
    
    func salvarTarefa(tarefa: String) {
        // recuperar tarefas
        tarefas = listarTarefas()
        
        // salvar
        tarefas.append(tarefa)
        UserDefaults.standard.set(tarefas, forKey: chaveListaTarefa)
    }
    
    func listarTarefas() -> Array<String> {
        
        let dados = UserDefaults.standard.object(forKey: chaveListaTarefa)
        if dados != nil {
            return dados as! Array
        } else {
            return []
        }
        
    }
    
    func removerTarefa(index: Int) {
        // Recupera as tarefas
        tarefas = listarTarefas()
        tarefas.remove(at: index)
        
        // Salvar Tarefas
        UserDefaults.standard.set(tarefas, forKey: chaveListaTarefa)
    }
}
