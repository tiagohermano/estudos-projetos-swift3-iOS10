//
//  ListaAnotacaoViewController.swift
//  Notas Diárias
//
//  Created by Tiago Hermano on 2/23/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import CoreData

class ListaAnotacaoViewController: UITableViewController {
    
    var gerenciadorObjetos: NSManagedObjectContext!
    var anotacoes: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configurar o Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        gerenciadorObjetos = appDelegate.persistentContainer.viewContext
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.recuperarAnotacoes()
    }
    
    func recuperarAnotacoes() {
        
        // Recupera todas as anotações
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Anotacao")
        
        // Ordenação da lista de anotações de acordo com a data
        let ordenacao = NSSortDescriptor(key: "data", ascending: false)
        requisicao.sortDescriptors = [ordenacao]
        
        do {
            let anotacoesRecuperadas = try gerenciadorObjetos.fetch(requisicao)
            self.anotacoes = anotacoesRecuperadas as! [NSManagedObject]
            self.tableView.reloadData()
            
            print("Anotacoes recuperadas com sucesso")
        } catch let erro as NSError {
            print("Erro ao listar Anotacoes. ERRO: \(erro.description)")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let anotacao = self.anotacoes[indexPath.row]
            
            // Remoção da anotação do Bando de Dados(Core Data)
            self.gerenciadorObjetos.delete(anotacao)
            // Remoção da anotação do Array de anotações
            self.anotacoes.remove(at: indexPath.row)
            
            do {
                try gerenciadorObjetos.save()
                self.tableView.deleteRows(at: [indexPath], with: .bottom)
                print("Sucesso ao deletar anotação")
            } catch let erro as NSError {
                print("Erro ao deletar anotação. ERRO: \(erro.localizedDescription)")
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Métodos de montagem da tabela

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.anotacoes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        // Configure the cell...
        let anotacao = self.anotacoes[indexPath.row]
        cell.textLabel?.text = anotacao.value(forKey: "texto") as? String
        
        let data = anotacao.value(forKey: "data")
        
        // Formatar a data
        let formatacaoData = DateFormatter()
        formatacaoData.dateFormat = "dd/MM/yyyy hh:mm"
        let novaData = formatacaoData.string(from: data as! Date)
        
        cell.detailTextLabel?.text = novaData

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Efeito de deseleção da linha clicada
        self.tableView.deselectRow(at: indexPath, animated: true)
        let anotacao = anotacoes[indexPath.row]
        self.performSegue(withIdentifier: "verAnotacao", sender: anotacao)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verAnotacao" {
            let viewControllerDestino = segue.destination as! AnotacaoViewController
            viewControllerDestino.anotacao = sender as? NSManagedObject
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
