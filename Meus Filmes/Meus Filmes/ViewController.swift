//
//  ViewController.swift
//  Meus Filmes
//
//  Created by tulio ferreira hermano on 14/02/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var filmes:[Filme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var filme: Filme
        
        filme = Filme(titulo: "007 - Spectre", descricao: "descricao 1", imagem: #imageLiteral(resourceName: "filme1"))
        filmes.append(filme)
        filme = Filme(titulo: "Star Wars", descricao: "descricao 2", imagem: #imageLiteral(resourceName: "filme2"))
        filmes.append(filme)
        filme = Filme(titulo: "Impacto Mortal", descricao: "descricao 3", imagem: #imageLiteral(resourceName: "filme3"))
        filmes.append(filme)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filme = filmes[ indexPath.row ]
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaReuso", for: indexPath ) as! FilmeCelula
        
        celula.filmeImageView.image = filme.imagem
        celula.tituloLabel.text = filme.titulo
        celula.descricaoLabel.text = filme.descricao
        
        celula.filmeImageView.layer.cornerRadius = 42
        celula.filmeImageView.clipsToBounds = true
        
        /*celula.textLabel?.text = filme.titulo
        celula.imageView?.image = filme.imagem*/
        
        return celula
    }
    
    // Método usado para passar dados de um ViewController para outro
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalhesFilme" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let filmeSelecionado = self.filmes[indexPath.row]
                let viewControllerDestino = segue.destination as! DetalhesFilmeViewController
                viewControllerDestino.filme = filmeSelecionado
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

