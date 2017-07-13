//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by iDev on 12/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var snaps: [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func sair(_ sender: Any) {
        
        let autenticacao = Auth.auth()
        do {
            try autenticacao.signOut()
            if let initialVC = self.storyboard?.instantiateInitialViewController() {
                self.present(initialVC, animated: true, completion: nil)
            } else {
                dismiss(animated: true, completion: nil)
            }
            
        } catch {
            print("Erro ao deslogar")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let autenticacao = Auth.auth()
        
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child(idUsuarioLogado).child("snaps")
            
            // Cria ouviente para snaps
            snaps.observe(.childAdded, with: { (snapshot) in
                
                let dados = snapshot.value as? NSDictionary
                
                let snap = Snap()
                snap.identificador = snapshot.key
                snap.nome = dados?["nome"] as! String
                snap.descricao = dados?["descricao"] as! String
                snap.urlImagem = dados?["urlImagem"] as! String
                snap.idImagem = dados?["idImagem"] as! String
                
                self.snaps.append(snap)
                self.tableView.reloadData()
                
            })
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let totalSnaps = snaps.count
        if totalSnaps == 0 {
            return 1
        } else {
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        let totalSnaps = snaps.count
        
        if totalSnaps == 0 {
            celula.textLabel?.text = "Nenhum snap para você :("
        } else {
            let snap = self.snaps[indexPath.row]
            celula.textLabel?.text = snap.nome
        }
        
        return celula
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
