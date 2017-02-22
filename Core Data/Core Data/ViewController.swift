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
        let produto = NSEntityDescription.insertNewObject(forEntityName: "Produtos", into: context)
        
        // Configurar objeto
        produto.setValue("Ovos", forKey: "nome")
        produto.setValue("descicao 3", forKey: "descricao")
        produto.setValue("Vermelho", forKey: "cor")
        produto.setValue(8.40, forKey: "preco")
        
        // Salvar valores no contexto(Requer uso do bloco: Try/Catch)
        do {
            try context.save()
            print("Dados salvos com sucesso!")
        } catch {
            print("Erro ao salvar os dados")
        }
        */
        
        //    Recuperar dados utilizando Core Data
 
        
        
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Produtos")
        
        //  Ordenar de A-Z
        let ordenacaoAZ = NSSortDescriptor(key: "nome", ascending: true)
        
        //  Ordenar de Z-A
        let ordenacaoZA = NSSortDescriptor(key: "preco", ascending: false)
        
        //  Aplicar Filtros
        //let predicate = NSPredicate(format: "nome == %@", "Manteiga")
        //let predicate = NSPredicate(format: "cor contains %@", "osa")
        //let predicate = NSPredicate(format: "cor contains [c] %@", "rosa")
        //let predicate = NSPredicate(format: "nome beginswith [c] %@", "Le")
        let filtroPreco = NSPredicate(format: "preco >= @%", "4.0")
        let filtroNome = NSPredicate(format: "nome == @% ", "Manteiga")
        
        let combinacaoFiltros = NSCompoundPredicate(andPredicateWithSubpredicates: [filtroPreco, filtroNome])
        //let combinacaoFiltros = NSCompoundPredicate(orPredicateWithSubpredicates: filtroPreco, filtroNome)
        
        // Aplicar filtros e requisicao
        requisicao.sortDescriptors = [ordenacaoAZ]
        requisicao.predicate = combinacaoFiltros
        
        do {
            let produtos = try context.fetch(requisicao)
            if produtos.count > 0 {
                for produto in produtos {
                    let nomeProduto = (produto as AnyObject).value(forKey: "nome")
                    let precoProduto = (produto as AnyObject).value(forKey: "preco")
                    let corProduto = (produto as AnyObject).value(forKey: "cor")
                    
                    print(String(describing: nomeProduto) + "-" + String(describing: precoProduto))
                }
            } else {
                print("Nenhum produto encontrado")
            }
            
            print("Sucesso ao recuperar os produtos")
        } catch {
            print("Erro ao recuperar os produtos")
        }
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

