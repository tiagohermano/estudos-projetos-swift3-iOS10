//
//  ViewController.swift
//  Alerta
//
//  Created by Dev12 on 14/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func abrirAlerta(_ sender: AnyObject) {
        
        // Criar Alerta
        let alertaController = UIAlertController(title: "Adicionar Contato", message: "Deseja adicionar o contato?", preferredStyle: .alert)
        // Criar Ações do alerta
        let acaoConfirmar = UIAlertAction(title: "Confirmar", style: .default, handler: nil)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        // Vincular as ações criadas ao alerta
        alertaController.addAction(acaoConfirmar)
        alertaController.addAction(acaoCancelar)
        
        
        present(alertaController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

