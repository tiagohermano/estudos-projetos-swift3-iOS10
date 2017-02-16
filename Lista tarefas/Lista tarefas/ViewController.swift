//
//  ViewController.swift
//  Lista tarefas
//
//  Created by Dev12 on 16/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var tarefas: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        atualizarListaTarefas()
    }
    
    // métodos TableViewController
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celulaReuso = "celulaReuso"
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath)
        celula.textLabel?.text = tarefas[indexPath.row]
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            let tarefaUserDefault = TarefaUserDefaults()
            tarefaUserDefault.removerTarefa(index: indexPath.row)
            atualizarListaTarefas()
            tableView.reloadData()
        }
        
    }
    
    func atualizarListaTarefas() {
        let tarefaUserDefaults = TarefaUserDefaults()
        tarefas = tarefaUserDefaults.listarTarefas()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        atualizarListaTarefas()
        
        // Método responsável por atualizar os dados da tableView
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

