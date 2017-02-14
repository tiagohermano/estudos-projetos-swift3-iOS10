//
//  DetalhesViewController.swift
//  Passando dados entre views
//
//  Created by Dev12 on 10/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import Foundation
import UIKit

class DetalhesViewController: UIViewController {
    @IBOutlet weak var resultadoLabel: UILabel!
    
    var textoRecebido: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultadoLabel.text = textoRecebido
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
