//
//  ViewController.swift
//  Snapchat
//
//  Created by iDev on 10/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Código responsável por logar usuário que já se logou anteriormente automaticamente ao abrir o app
        let autenticacao = Auth.auth()
        autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
            if let usuarioLogado = usuario {
                self.performSegue(withIdentifier: "autoLoginSegue", sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIViewController {
    func exibirMensagem(titulo: String, mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoDismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alerta.addAction(acaoDismiss)
        present(alerta, animated: true, completion: nil)
    }
}
