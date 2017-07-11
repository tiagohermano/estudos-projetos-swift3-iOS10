//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by iDev on 11/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBAction func logar(_ sender: Any) {
        if let email = emailTextField.text, let senha = senhaTextField.text {
            // Autenticar usuário no Firebase
            let autenticacao = Auth.auth()
            autenticacao.signIn(withEmail: email, password: senha, completion: { (usuario, erro) in
                if erro == nil {
                    if usuario == nil {
                        self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticação")
                    } else {
                        // Redireciona usuário para a tela principal
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    }
                } else {
                    let erroR = erro! as NSError
                    if let codigoErro = erroR.userInfo["error_name"] {
                        let erroTexto = codigoErro as! String
                        var mensagemErro = ""
                        
                        switch erroTexto {
                        case "ERROR_INVALID_EMAIL":
                            mensagemErro = "E-mail inválido, digite um e-mail válido!"
                            break
                        case "ERROR_WEAK_PASSWORD":
                            mensagemErro = "Senha Incompleta. Senha precisa ter no mínimo 6 caracteres, com letras e números."
                            break
                        default:
                            mensagemErro = "Erro ao fazer login."
                        }
                        self.exibirMensagem(titulo: "Dados incorretos", mensagem: mensagemErro)
                    }
                }
            })
        }
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
