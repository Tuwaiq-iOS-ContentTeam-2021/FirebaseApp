//
//  Constants.swift
//  Millao-Swift
//
//  Created by Lola on 10/11/2015.
//  Copyright © 2015 Globewyze. All rights reserved.
//

import UIKit
import Firebase

let firebaseManager = FirebaseManager.shared
let dataManager = DataManager.shared
let firebaseAuth = Auth.auth()

public let MB_DEVICE_MODEL =  UIDevice.current.model

public let MB_IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad

public let MB_APP_NAME = Bundle.main.infoDictionary!["CFBundleName"] as? String ?? ""

public let MB_APP_ID = Bundle.main.bundleIdentifier

struct Constants {
    static let timeUpdateNotification = NSNotification.Name(rawValue: "timerUpdated")
    static let video = "Video"
    static let actionFileTypeHeading = "Add a File"
    static let actionFileTypeDescription = "Choose a filetype to add..."
    static let camera = "Camera"
    static let phoneLibrary = "Photo"
    static let file = "File"
    
    
    static let alertForPhotoLibraryMessage = "App does not have access to your photos. To enable access, tap settings and turn on Photo Library Access."
    
    static let alertForCameraAccessMessage = "App does not have access to your camera. To enable access, tap settings and turn on Camera."
    
    static let alertForVideoLibraryMessage = "App does not have access to your video. To enable access, tap settings and turn on Video Library Access."
}
