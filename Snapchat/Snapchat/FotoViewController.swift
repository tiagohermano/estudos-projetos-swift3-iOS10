//
//  FotoViewController.swift
//  Snapchat
//
//  Created by iDev on 12/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var botaoProximo: UIButton!
    
    var imagePicker = UIImagePickerController()
    var idImagem = NSUUID().uuidString

    @IBAction func proximoPasso(_ sender: Any) {
        
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        
        // Recuperar a Imagem
        if let imagemSelecionada = imagem.image {
            if let imagemDados = UIImageJPEGRepresentation(imagemSelecionada, 0.1) {
                imagens.child("\(self.idImagem).jpg").putData(imagemDados, metadata: nil, completion: { (metaDados, erro) in
                    if erro == nil {
                        print("Sucesso ao fazer upload do arquivo")
                        
                        let url = metaDados?.downloadURL()?.absoluteString
                        self.performSegue(withIdentifier: "selecionarUsuarioSegue", sender: url)
                        
                        self.botaoProximo.isEnabled = true
                        self.botaoProximo.setTitle("Próximo", for: .normal)
                    } else {
                        self.exibirMensagem(titulo: "Upload falhou", mensagem: "Erro ao salvar o arquivo, tente novamente!")
                    }
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selecionarUsuarioSegue" {
            let usuarioViewController = segue.destination as! UsuariosTableViewController
            usuarioViewController.descricao = self.descricao.text!
            usuarioViewController.urlImagem = sender as! String
            usuarioViewController.idImagem = self.idImagem
        }
    }
    
    @IBAction func selecionarFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        botaoProximo.isEnabled = false
        botaoProximo.backgroundColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imagemRecuperada = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imagem.image = imagemRecuperada
        imagePicker.dismiss(animated: true, completion: nil)
        
        self.botaoProximo.isEnabled = true
        self.botaoProximo.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1.0)
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
