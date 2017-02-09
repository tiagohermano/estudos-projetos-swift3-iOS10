//
//  ViewController.swift
//  Frases do dia
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
    @IBAction func novaFrase(_ sender: AnyObject) {
        var frases : [String] = []
        var numeroAleatorio = arc4random_uniform(3)
        frases.append("Frase 1")
        frases.append("Frase 2")
        frases.append("Frase 3")
        
        legendaResultado.text = frases[Int(numeroAleatorio)]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

