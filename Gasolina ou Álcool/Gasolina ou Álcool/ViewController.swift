//
//  ViewController.swift
//  Gasolina ou Álcool
//
//  Created by Dev12 on 09/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var precoAlcoolTextField: UITextField!
    @IBOutlet weak var precoGasolinaTextField: UITextField!
    @IBOutlet weak var resultadoLabel: UILabel!
    
    @IBAction func calcularCombustivel(_ sender: AnyObject) {
        var precoAlcool: Double = 0
        var precoGasolina: Double = 0
        var resultadoPreco: Double = 0
        
        //Validações
        if let resultadoAlcool = precoAlcoolTextField.text {
            if resultadoAlcool != "" {
                if let resultadoNumero = Double(resultadoAlcool){
                    precoAlcool = resultadoNumero
                }
            }
        }
        if let resultadoGasolina = precoGasolinaTextField.text {
            if resultadoGasolina != "" {
                if let resultadoNumero = Double(resultadoGasolina){
                    precoGasolina = resultadoNumero
                }
            }
        }
        
        //Cálculo
        resultadoPreco = precoAlcool / precoGasolina
        if resultadoPreco <= 0.7 {
            resultadoLabel.text = "Álcool é a melhor opção"
        } else {
            resultadoLabel.text = "Gasolina é a melhor opção"
        }
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

