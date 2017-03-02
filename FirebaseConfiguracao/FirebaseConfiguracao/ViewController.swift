//
//  ViewController.swift
//  FirebaseConfiguracao
//
//  Created by Tiago Hermano on 3/2/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var textoLabel: UILabel!
    let firebase = FIRDatabase.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("Erro ao deslogar o usuário")
        }
         */
        
        // Fazer login do usuário
        FIRAuth.auth()?.signIn(withEmail: "dev13.seucondominio@gmail.com", password: "dev123456", completion: { (usuario, erro) in
            
            if erro == nil {
                print("Sucesso ao fazer login do usuário")
            } else {
                print("Erro ao fazer login do usuário. \(erro?.localizedDescription)")
            }
            
        })
        
        // Verificar se usuário está logado
        FIRAuth.auth()?.addStateDidChangeListener({ (FIRAuth, usuario) in
            if let usuarioLogado = usuario {
                print("Usuario está logado. Email: " + String(describing: usuarioLogado.email))
            } else {
                print("Usuario não está logado")
            }
        })
        
        /*
        // Criar Usuário com FireBase
        FIRAuth.auth()?.createUser(withEmail: "dev13.seucondominio@gmail.com", password: "dev123456", completion: { (usuario, erro) in
            if erro == nil {
                print("Sucesso ao cadastrar o usuário")
            } else {
                print("Erro ao cadastrar usuario \(erro?.localizedDescription)")
            }
        })
 
        // Verificar se usuário está logado(Ao criar usuário, este é automaticamente logado por padrão)
        FIRAuth.auth()?.addStateDidChangeListener({ (FIRAuth, usuario) in
            if let usuarioLogado = usuario {
                print("Usuario está logado. Email: " + String(describing: usuarioLogado.email))
            } else {
                print("Usuario não está logado")
            }
        })
        */
        
        /*
        
        let pontuacao = firebase.child("pontuacao").child("valor")
        // pontuacao.removeValue()
        // pontuacao.child("valor").setValue("100")
        
        // Recuperar dados do Firebase
        pontuacao.observe(FIRDataEventType.value, with: {(dados) in
            let ponto = dados.value as! String
            self.textoLabel.text = ponto
        })
         */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

