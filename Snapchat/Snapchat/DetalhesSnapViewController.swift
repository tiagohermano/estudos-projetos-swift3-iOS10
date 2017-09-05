//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by iDev on 13/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetalhesSnapViewController: UIViewController {
    @IBOutlet weak var snapImageView: UIImageView!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var contadorLabel: UILabel!
    
    var snap = Snap()
    var tempo = 11

    override func viewDidLoad() {
        super.viewDidLoad()
        descricaoLabel.text = "Carregando ..."
        contadorLabel.isHidden = true
        contadorLabel.layer.cornerRadius = contadorLabel.layer.bounds.width / 2

        let url = URL(string: snap.urlImagem)
        snapImageView.sd_setImage(with: url) { (imagem, erro, cache, url) in
            if erro == nil {
                
                self.contadorLabel.isHidden = false
                self.descricaoLabel.text = self.snap.descricao
                
                // inicializar o timer
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    
                    //decrementar tempo
                    self.tempo = self.tempo-1
                    
                    //Exibir timer na tela
                    self.contadorLabel.text = String(self.tempo)
                    
                    //caso o timer chegue até 0, invalida o timer
                    if self.tempo == 0 {
                        timer.invalidate()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            
            // Remove nós do banco de dados
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            
            let snaps = usuarios.child(idUsuarioLogado).child("snaps")
            snaps.child(snap.identificador).removeValue()
            
            // Remove imagem do Snap
            let storage = Storage.storage().reference()
            let imagens = storage.child("imagens")
            
            imagens.child("\(snap.idImagem).jpg").delete(completion: { (erro) in
                if erro == nil {
                    print("Sucesso ao excluir imagem")
                } else {
                    print("Erro ao excluir imagem")
                }
            })
        }
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
