//
//  Usuario.swift
//  Snapchat
//
//  Created by iDev on 13/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import Foundation

class Usuario {
    
    var email:String
    var nome:String
    var uid:String
    
    init(email:String, nome:String, uid:String) {
        self.email = email
        self.nome = nome
        self.uid = uid
    }
    
}
