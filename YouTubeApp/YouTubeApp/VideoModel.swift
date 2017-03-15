//
//  VideoModel.swift
//  YouTubeApp
//
//  Created by Tiago Hermano on 10/03/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import Alamofire

class VideoModel: NSObject {
    
    let API_KEY = "AIzaSyAxs6a5WDudoexHffR02djjIVjmeCWgWGw"
    let UPLOADS_PLAYLISTS_ID = "UU2D6eRvCeMtcF5OGHf1-trw"
    let BASE_URL = "https://googleapis.com/youtube/v3/playlists"
    
    func getFeedVideos() {
        
        // Fetch the videos dynamically through the YouTube Data API
        //Alamofire.request(BASE_URL, method: .get, parameters: ["part":"snippet","playlistId":UPLOADS_PLAYLISTS_ID,"key":API_KEY], encoding: ParameterEncoding.URL, headers: nil)
        
        
        Alamofire.request("https://googleapis.com/youtube/v3/playlists", method: .get, parameters: ["part":"snippet","playlistId":UPLOADS_PLAYLISTS_ID,"key":API_KEY], encoding: ParameterEncoding, headers: nil).responseJSON { (response) in
            
            if let JSON = response.result.value {
                for video in JSON["items"] as! NSArray{
                    print(video)
                }
            }
        }
    }
    
    func getVideos() -> [Video] {
        
        var videos = [Video]()
        
        let video1 = Video()
        
        video1.videoId = "mlzu_DXtG80"
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
