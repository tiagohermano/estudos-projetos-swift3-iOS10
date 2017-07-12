//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by iDev on 11/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CadastroViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nomeCompletoTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var senhaConfirmacaoTextField: UITextField!
    
    @IBAction func criarConta(_ sender: Any) {
        
        if let email = self.emailTextField.text, let nomeCompleto = self.nomeCompletoTextField.text, let senha = self.senhaTextField.text, let senhaConfirmacao = self.senhaConfirmacaoTextField.text {
            
            // Validar senha
            if senha == senhaConfirmacao {
                
                // Validação do nome
                if nomeCompleto != "" {
                    
                    // Criar conta no Firebase
                    let autenticacao = Auth.auth()
                    autenticacao.createUser(withEmail: email, password: senha, completion: { (usuario, erro) in
                        
                        if erro == nil {
                            if usuario == nil {
                                self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticação. Tente novamente")
                            } else {
                                
                                let database = Database.database().reference()
                                let usuarios = database.child("usuarios")
                                
                                let usuarioDados = ["nome": nomeCompleto, "email": email]
                                usuarios.child(usuario!.uid).setValue(usuarioDados)
                                
                                // Redireciona usuário para a tela principal
                                self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                            }
                            
                        } else {
                            // Tratamento erro login Firebase
                            let erroR = erro! as NSError
                            if let codigoErro = erroR.userInfo["error_name"] {
                                let erroTexto = codigoErro as! String
                                var mensagemErro = ""
                                
                                switch erroTexto {
                                case "ERROR_INVALID_EMAIL":
                                    mensagemErro = "E-mail inválido, digite um e-mail válido!"
                                    break
                                case "ERROR_WEAK_PASSWORD":
                                    mensagemErro = "Senha precisa ter no mínimo 6 caracteres, com letras e números."
                                    break
                                case "ERROR_EMAIL_ALREADY_IN_USE":
                                    mensagemErro = "Esse e-mail já está sendo utilizado, crie sua conta com outro e-mail."
                                    break
                                default:
                                    mensagemErro = "Erro ao cadastrar usuário"
                                }
                                
                                self.exibirMensagem(titulo: "Dados inválidos", mensagem: mensagemErro)
                            }
                        }
                    })
                } else {
                    exibirMensagem(titulo: "Nome", mensagem: "Digite seu nome para proseeguir")
                }
                
            } else {
                exibirMensagem(titulo: "Atenção", mensagem: "Senhas precisam ser iguais")
            }
            
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
