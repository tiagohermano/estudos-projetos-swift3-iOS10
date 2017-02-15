//
//  ViewController.swift
//  Salvar Dados Usuario
//
//  Created by Dev12 on 15/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Salvar Objetos de forma permanente
        UserDefaults.standard.set("azul", forKey: "corFundo")
        
        let array: [String] = ["Lasanha", "Pizza", "Torta"]
        UserDefaults.standard.set(array, forKey: "comidas")
        
        // Remover objetos
        UserDefaults.standard.removeObject(forKey: "comidas")
        
        // Recuperar Objetos Salvos
        let arrayRecuperado = UserDefaults.standard.object(forKey: "comidas")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

