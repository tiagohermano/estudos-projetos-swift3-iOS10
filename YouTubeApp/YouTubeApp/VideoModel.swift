//
//  VideoModel.swift
//  YouTubeApp
//
//  Created by tulio ferreira hermano on 10/03/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit

class VideoModel: NSObject {
    
    func getVideos() -> [Video]{
        
        var videos = [Video]()
        
        let video1 = Video()
        
        video1.videoId = "48kekFLZkXU"
        video1.videoTitle = "Tutorial: How to suck your own dick"
        video1.videoDescription = "Totally not gay"
        
        videos.append(video1)
        
        
        let video2 = Video()
        
        video2.videoId = "48kekFLZkXU"
        video2.videoTitle = "Tutorial: How to suck your own dick"
        video2.videoDescription = "Totally not gay"
        
        videos.append(video2)
        
        
        let video3 = Video()
        
        video3.videoId = "48kekFLZkXU"
        video3.videoTitle = "Tutorial: How to suck your own dick"
        video3.videoDescription = "Totally not gay"
        
        videos.append(video3)
        
        let video4 = Video()
        
        video4.videoId = "48kekFLZkXU"
        video4.videoTitle = "Tutorial: How to suck your own dick"
        video4.videoDescription = "Totally not gay"
        
        videos.append(video4)
        
        let video5 = Video()
        
        video5.videoId = "48kekFLZkXU"
        video5.videoTitle = "Tutorial: How to suck your own dick"
        video5.videoDescription = "Totally not gay"
        
        videos.append(video5)
        
        
        return videos
    }
}
