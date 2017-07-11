//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by iDev on 11/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var senhaConfirmacaoTextField: UITextField!
    
    @IBAction func criarConta(_ sender: Any) {
        
        // Recuperar dados digitados
//        if let email = self.emailTextField.text {
//            if let senha = self.senhaTextField.text {
//                if let senhaConfirmacao = self.senhaConfirmacaoTextField.text {
//                    
//                }
//            }
//        }
        
        if let email = self.emailTextField.text, let senha = self.senhaTextField.text, let senhaConfirmacao = self.senhaConfirmacaoTextField.text {
            
            // Validar senha
            if senha == senhaConfirmacao {
                // Criar conta no Firebase
                let autenticacao = Auth.auth()
                autenticacao.createUser(withEmail: email, password: senha, completion: { (usuario, erro) in
                    
                    if erro == nil {
                        print("Sucesso ao cadastrar usuário")
                    } else {
                        print("Erro ao cadastrar usuário")
                    }
                })
                
            } else {
                exibirMensagem(titulo: "Atenção", mensagem: "Senhas precisam ser iguais")
            }
        }
        
    }
    
    private func exibirMensagem(titulo: String, mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoDismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alerta.addAction(acaoDismiss)
        present(alerta, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
