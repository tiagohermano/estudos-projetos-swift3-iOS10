//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by iDev on 21/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let cellId = "cellId"
    let cellHeight = 50
    
    let settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "gear"), Setting(name: "Terms & Privacy Policy", imageName: "lock"),
                Setting(name: "Send feedback", imageName: "alert"), Setting(name: "Help", imageName: "help"),
                Setting(name: "Switch Account", imageName: "user_profile"), Setting(name: "Cancel", imageName: "close")]
    }()
    
    lazy var collectionViewSettings: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    func showSettings() {
        // mais opções
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            
            window.addSubview(collectionViewSettings)
            
            let height: CGFloat = CGFloat(settings.count * cellHeight)
            let y = window.frame.height - height
            collectionViewSettings.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                
                self.collectionViewSettings.frame = CGRect(x: 0, y: y, width: self.collectionViewSettings.frame.width, height: self.collectionViewSettings.frame.height)
            }, completion: nil)
            
        }
    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionViewSettings.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionViewSettings.frame.width, height: self.collectionViewSettings.frame.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewSettings.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override init() {
        super.init()
        collectionViewSettings.dataSource = self
        collectionViewSettings.delegate = self
        
        collectionViewSettings.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}
