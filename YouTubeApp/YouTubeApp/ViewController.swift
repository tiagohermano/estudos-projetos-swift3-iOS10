//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Tiago Hermano on 10/03/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var videos:[Video] = [Video]()
    var selectedVideo:Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let model = VideoModel()
        self.videos = model.getVideos()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Identificar a largura da tela para calcular a altura da célula
        return (self.view.frame.size.width / 320) * 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        
        let videoTitle = videos[indexPath.row].videoTitle
        
        // Recuperar label para a célula
        let label = cell.viewWithTag(2) as! UILabel
        label.text = videoTitle
        
        // Construir o url do thumbnail do video
        let videoThumbnailUrlString = "https://img.youtube.com/vi/" + videos[indexPath.row].videoId + "/maxresdefault.jpg"
        
        // Criar um objeto NSURL
        if let videoThumbnailUrl = NSURL(string: videoThumbnailUrlString) {
            // Criar um objeto de requisicao NSURL
            let request = URLRequest(url: videoThumbnailUrl as! URL)
            
            // Criar uma NSURLSession
            let session = URLSession.shared
            
            // Criar uma datatask e passar a requisicão
            let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                
                DispatchQueue.main.async(execute: { 
                    // Pegar uma referência para o elemento imageView da célula
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    
                    // Criar um objeto imagem dos dados e vincula-la no imageView
                    imageView.image = UIImage(data: data!)
                })
            })
            
            dataTask.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Take note on which video the user selected
        self.selectedVideo = self.videos[indexPath.row]
        
        // Call the segue manually
        self.performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get a reference to the destination view controller
        let detailViewController = segue.destination as! VideoDetailViewController
        
        // Set the selected video property of the destination view controller
        detailViewController.selectedVideo = self.selectedVideo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

