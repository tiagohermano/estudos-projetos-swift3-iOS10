//
//  TarefaViewController.swift
//  Lista tarefas
//
//  Created by Dev12 on 16/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class TarefaViewController: UIViewController {

    @IBOutlet weak var tarefaTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func adicionarTarefa(_ sender: AnyObject) {
        if let tarefa = tarefaTextField.text {
            let tarefaUserDefaults = TarefaUserDefaults()
            tarefaUserDefaults.salvarTarefa(tarefa: tarefa)
            
            // limpar o campo depois de adicionar uma tarefa
            tarefaTextField.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
