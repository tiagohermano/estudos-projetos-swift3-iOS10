//
//  LocaisViagemTableViewController.swift
//  Minhas viagens
//
//  Created by Dev12 on 20/02/17.
//  Copyright © 2017 Tiago-Dev13. All rights reserved.
//

import UIKit

class LocaisViagemTableViewController: UITableViewController {
    
    var locaisViagens: [Dictionary<String,String>] = []
    var controlerNavegacao = "adicionar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        controlerNavegacao = "adicionar"
        self.atualizarViagens()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locaisViagens.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaReuso", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = self.locaisViagens[indexPath.row]["local"]
        
        return cell
    }
    
    // Método responsável por adicionar ação nativa de 'Delete' em cada Célula da TableView
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            ArmazenamentoDados().removerViagem(index: indexPath.row)
            self.atualizarViagens()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.controlerNavegacao = "listar"
        performSegue(withIdentifier: "verLocal", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verLocal" {
            let viewControllerDestino = segue.destination as! ViewController
            
            if self.controlerNavegacao == "listar" {
                if let indiceRecuperado = sender {
                    let indice = indiceRecuperado as! Int
                    viewControllerDestino.viagem = locaisViagens[indice]
                    viewControllerDestino.indiceSelecionado = indice
                }
            } else {
                viewControllerDestino.viagem = [:]
                viewControllerDestino.indiceSelecionado = -1
            }
        }
    }
    
    func atualizarViagens() {
        locaisViagens = ArmazenamentoDados().listarViagens()
        tableView.reloadData()
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
