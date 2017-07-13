//
//  UsuariosTableViewController.swift
//  Snapchat
//
//  Created by iDev on 13/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsuariosTableViewController: UITableViewController {
    
    var usuarios: [Usuario] = []
    var urlImagem = ""
    var descricao = ""
    var idImagem = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let database = Database.database().reference()
        let usuarios = database.child("usuarios")
        
        // Adiciona evento novo usuário adicionado
        usuarios.observe(DataEventType.childAdded, with: { (snapshot) in
            if let dados = snapshot.value as? NSDictionary {
                let emailUsuario = dados["email"] as! String
                let nomeUsuario = dados["nome"] as! String
                let idUsuario = snapshot.key
                
                let usuario = Usuario(email: emailUsuario, nome: nomeUsuario, uid: idUsuario)
                self.usuarios.append(usuario)
                self.tableView.reloadData()
            }
        })
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
        return self.usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        // Configure the cell...
        let usuario = self.usuarios[indexPath.row]
        cell.textLabel?.text = usuario.nome
        cell.detailTextLabel?.text = usuario.email

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuarioSelecionado = self.usuarios[indexPath.row]
        
        let idUsuarioSelecionado = usuarioSelecionado.uid
        
        // Recupera referência do banco de dados
        let database = Database.database().reference()
        let usuarios = database.child("usuarios")
        let snaps = usuarios.child(idUsuarioSelecionado).child("snaps")
        
        // Recuperar dados do usuário logado
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            
            let usuarioLogado = usuarios.child(idUsuarioLogado)
            usuarioLogado.observeSingleEvent(of: .value, with: { (snapshot) in
                let dados = snapshot.value as? NSDictionary
                
                let snap = [
                    "remetente": dados?["email"] as! String,
                    "nome": dados?["nome"] as! String,
                    "descricao": self.descricao,
                    "urlImagem": self.urlImagem,
                    "idImagem": self.idImagem
                ]
                
                snaps.childByAutoId().setValue(snap)
                
                self.navigationController?.popToRootViewController(animated: true)
                
            })
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
