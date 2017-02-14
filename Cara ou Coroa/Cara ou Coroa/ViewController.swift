//
//  ViewController.swift
//  Cara ou Coroa
//
//  Created by Dev12 on 14/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jogarMoeda" {
            let numeroRandomico = arc4random_uniform(2)
            
            // Criado objeto que permitirá comunicação entre ViewController(primeira tela) e DetalhesViewController(segunda tela)
            let viewControllerDestino = segue.destination as! DetalhesViewController
            
            viewControllerDestino.numeroRandomicoRecebido = Int(numeroRandomico)
        }
    }
}

