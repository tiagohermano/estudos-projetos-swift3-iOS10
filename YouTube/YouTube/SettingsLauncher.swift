//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by iDev on 21/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: settingName
    let imageName: String
    
    init(name: settingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum settingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let cellId = "cellId"
    let cellHeight = 50
    
    let settings: [Setting] = {
        let cancelSetting = Setting(name: .Cancel, imageName: "close")
        let settingsSetting = Setting(name: .Settings, imageName: "gear")
        let termsPrivacySetting = Setting(name: .TermsPrivacy, imageName: "lock")
        let helpSetting = Setting(name: .Help, imageName: "help")
        let sendFeedbackSetting = Setting(name: .SendFeedback, imageName: "alert")
        let switchAccountSetting = Setting(name: .SwitchAccount, imageName: "user_profile")
        
        
        return [settingsSetting, termsPrivacySetting,
                sendFeedbackSetting, helpSetting,
                switchAccountSetting, cancelSetting]
    }()
    
    lazy var collectionViewSettings: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    var homeController: HomeController?
    
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
    
    func handleDismiss(_ setting:Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionViewSettings.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionViewSettings.frame.width, height: self.collectionViewSettings.frame.height)
            }
            
        }) { (completed: Bool) in
            
            if 	setting.name != .Cancel {
                self.homeController?.showControllerForSetting(setting)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]
        handleDismiss(setting)
    }
    
    override init() {
        super.init()
        collectionViewSettings.dataSource = self
        collectionViewSettings.delegate = self
        
        collectionViewSettings.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}
