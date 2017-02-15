//
//  Filme.swift
//  Meus Filmes
//
//  Created by tulio ferreira hermano on 14/02/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit

class Filme {
    var titulo : String!
    var descricao : String!
    var imagem : UIImage!
    
    init(titulo: String, descricao: String, imagem: UIImage){
        self.titulo = titulo
        self.descricao = descricao
        self.imagem = imagem
    }
}
