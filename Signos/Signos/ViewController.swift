//
//  ViewController.swift
//  Signos
//
//  Created by Dev12 on 14/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var signos:[String] = []
    var significadoSignos:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        signos.append("Áries")
        signos.append("Touro")
        signos.append("Gêmeos")
        signos.append("Câncer")
        
        significadoSignos.append("Texto Áries")
        significadoSignos.append("Texto Touro")
        significadoSignos.append("Texto Gêmeos")
        significadoSignos.append("Texto Câncer")
        
    }
   
    // Início dos 3 métodos necessários para construção de uma TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celulaReuso = "celulaReuso"
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath)
        celula.textLabel?.text = signos[indexPath.row]
        
        return celula
    }
    // Fim dos 3 métodos necessários para construção de uma TableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Efeito de animação: Ao clicar em uma célula da tabela, esta é selecionada e desselecionada rapidamente
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Criação de um alerta para exibição do significado do signo
        let alertaController = UIAlertController(title: "Significado do signo", message: significadoSignos[ indexPath.row ], preferredStyle: .alert)
        // Criação de uma ação para o alert(botão confirmar)
        let acaoConfirmar = UIAlertAction(title: "Fechar", style: .default, handler: nil)
        // Add ação da ação no alert
        alertaController.addAction(acaoConfirmar)
        
        // Apresentação do alerta
        present(alertaController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

