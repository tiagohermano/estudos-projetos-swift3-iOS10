//
//  ViewController.swift
//  Gerador Numeros Aula
//
//  Created by Dev12 on 09/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var legendaResultado: UILabel!
    @IBAction func gerarNumero(_ sender: AnyObject) {
        var numeroAleatorio = arc4random_uniform(11)
        legendaResultado.text = String(numeroAleatorio)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

