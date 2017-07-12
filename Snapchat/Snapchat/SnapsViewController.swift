//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by iDev on 12/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {
    
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

        // Do any additional setup after loading the view.
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
