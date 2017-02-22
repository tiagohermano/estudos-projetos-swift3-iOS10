//
//  ViewController.swift
//  Core Data
//
//  Created by Tiago Hermano on 2/22/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurações iniciais para utitlizar o Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // gerenciador de persistencia de dados utilizando o Core Data
        let context = appDelegate.persistentContainer.viewContext
        
        /*
        //    Como salvar dados utilizando o Core Data
        
        let usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuarios", into: context)
        
        // Configurar objeto
        usuario.setValue("teste", forKey: "loginUsuario")
        usuario.setValue("123", forKey: "senha")
        usuario.setValue("Teste", forKey: "nome")
        usuario.setValue(40, forKey: "idade")
        
        // Salvar valores no contexto(Requer uso do bloco: Try/Catch)
        do {
            try context.save()
            print("Dados salvos com sucesso!")
        } catch {
            print("Erro ao salvar os dados")
        }
        */
        /*
            Recuperar dados utilizando Core Data
        */
        
 
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuarios")
    
        do {
            let usuarios = try context.fetch(requisicao)
            if usuarios.count > 0 {
                for usuario in usuarios {
                    if let nomeUsuario = (usuario as AnyObject).value(forKey: "nome") {
                        print(nomeUsuario)	
                    }
                }
            } else {
                print("Nenhum usuario encontrado")
            }
        } catch {
            print("Erro ao recuperar ao dados!")
        }
 
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

