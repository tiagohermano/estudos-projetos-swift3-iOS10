//
//  ViewController.swift
//  Notas Diárias
//
//  Created by Tiago Hermano on 2/23/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {
    
    @IBOutlet weak var texto: UITextView!
    var gerenciadorObjetos: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar o Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        gerenciadorObjetos = appDelegate.persistentContainer.viewContext
        
        //Abrir automáticamente o teclado quando abrir a tela 'Adicionar'
        self.texto.becomeFirstResponder()
        self.texto.text = ""
    }

    
    @IBAction func salvarAnotacao(_ sender: Any) {
        self.salvar()
        
        // Retornar para a tela inicial
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func salvar() {
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: gerenciadorObjetos)
        
        // Configurar anotação
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(NSDate(), forKey: "data")
        
        // Salvar dados
        do {
            try gerenciadorObjetos.save()
            print("Anotação salva com sucesso")
        } catch let erro as NSError{
            print("Não foi possível salvar a anotação. Erro: \(erro.description)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

