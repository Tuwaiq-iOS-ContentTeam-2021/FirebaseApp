//
//  MediaPickerViewController.swift
//  GroupFlow App
//
//  Created by Lola M on 12/12/21.
//  Copyright © 2018 Swam Tech. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Photos

class MediaPickerViewController: UIViewController {

    weak var delegate: MediaPickerControllerDelegate?
    
    var isLoadedFirst = false
    var supportedMediaTypes : SupportedMediaTypes = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if(isLoadedFirst == false) {
            self.showAttachmentActionSheet()
            isLoadedFirst = true
        }
    }

    
    func showAttachmentActionSheet() {
       
        let actionSheet = UIAlertController(title: Constants.actionFileTypeHeading, message: Constants.actionFileTypeDescription, preferredStyle: .actionSheet)
        
        switch self.supportedMediaTypes {
        case .all:
            actionSheet.addAction(UIAlertAction(title: Constants.phoneLibrary, style: .default, handler: { (action) -> Void in
                self.authorisationStatus(attachmentTypeEnum: .photoLibrary)
            }))
            
            actionSheet.addAction(UIAlertAction(title: Constants.video, style: .default, handler: { (action) -> Void in
                self.authorisationStatus(attachmentTypeEnum: .video)
            }))
            
            actionSheet.addAction(UIAlertAction(title: Constants.file, style: .default, handler: { (action) -> Void in
                self.documentPicker()
            }))
        
        case .image:
            actionSheet.addAction(UIAlertAction(title: Constants.phoneLibrary, style: .default, handler: { (action) -> Void in
                self.authorisationStatus(attachmentTypeEnum: .photoLibrary)
            }))
            
            actionSheet.addAction(UIAlertAction(title: Constants.file, style: .default, handler: { (action) -> Void in
                self.documentPicker()
            }))
            
        case .video:
            actionSheet.addAction(UIAlertAction(title: Constants.video, style: .default, handler: { (action) -> Void in
                self.authorisationStatus(attachmentTypeEnum: .video)
            }))
            
            actionSheet.addAction(UIAlertAction(title: Constants.file, style: .default, handler: { (action) -> Void in
                self.documentPicker()
            }))
            
        case .audio:
            actionSheet.addAction(UIAlertAction(title: Constants.file, style: .default, handler: { (action) -> Void in
                self.documentPicker()
            }))

        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in
            self.cancelPicking()
        }))
        
        if let popoverController = actionSheet.popoverPresentationController {
            actionSheet.isModalInPopover = true
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = self.view.bounds // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    //MARK: - Authorisation Status
    // This is used to check the authorisation status whether user gives access to import the image, photo library, video.
    // if the user gives access, then we can import the data safely
    // if not show them alert to access from settings.
    func authorisationStatus(attachmentTypeEnum: AttachmentType) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            if attachmentTypeEnum == AttachmentType.photoLibrary{
                photoLibrary()
            }
            if attachmentTypeEnum == AttachmentType.video{
                videoLibrary()
            }
        case .denied:
            print("permission denied")
            self.addAlertForSettings(attachmentTypeEnum)
        case .notDetermined:
            print("Permission Not Determined")
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized{
                    if attachmentTypeEnum == AttachmentType.photoLibrary{
                        self.photoLibrary()
                    }
                    if attachmentTypeEnum == AttachmentType.video{
                        self.videoLibrary()
                    }
                }else{
                    print("restriced manually")
                    self.addAlertForSettings(attachmentTypeEnum)
                }
            })
        case .restricted:
            print("permission restricted")
            self.addAlertForSettings(attachmentTypeEnum)
        default:
            break
        }
    }
    
    //MARK: - CAMERA PICKER
    //This function is used to open camera from the iphone and
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - PHOTO PICKER
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: - VIDEO PICKER
    func videoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: - FILE PICKER
    func documentPicker() {
        var importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypeAudio), String(kUTTypeVideo), String(kUTTypeImage), String(kUTTypeMovie)], in: .import)
        
        switch self.supportedMediaTypes {
        case .image:
            
            importMenu = UIDocumentPickerViewController(documentTypes:[String(kUTTypeImage)] , in: .import)
        default:
            break
        }
        
        importMenu.delegate = self
        
        self.present(importMenu, animated: true, completion: nil)
    }
    
    
    //MARK: - SETTINGS ALERT
    func addAlertForSettings(_ attachmentTypeEnum: AttachmentType){
        var alertTitle: String = ""
    
        if attachmentTypeEnum == AttachmentType.photoLibrary{
            alertTitle = Constants.alertForPhotoLibraryMessage
        }
        if attachmentTypeEnum == AttachmentType.video{
            alertTitle = Constants.alertForVideoLibraryMessage
        }
        
        let cameraUnavailableAlertController = UIAlertController (title: alertTitle , message: nil, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string:UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        cameraUnavailableAlertController .addAction(cancelAction)
        cameraUnavailableAlertController .addAction(settingsAction)
        self.present(cameraUnavailableAlertController , animated: true, completion: nil)
    }
    
    func finishedPicking(media: MediaType, url: URL?, error: Error?) {
        DispatchQueue.main.async {
            self.delegate?.picker(self, didFinishPickingMedia: media, url: url, error: error)
        }
    }
    
    func cancelPicking() {
        DispatchQueue.main.async {
            self.delegate?.pickerDidCancel(self)
            self.dismiss(animated: false)
        }
    }
}

extension MediaPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.cancelPicking()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker.dismiss(animated: true)
        
        //Image
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
//            let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? NSURL,
            let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL,
            let localPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imageURL.lastPathComponent ?? "image.jpeg"),
            let data = image.pngData() {
            try? data.write(to: localPath)
            self.finishedPicking(media: .image, url: localPath, error: nil)
        } else if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
            self.compressWithSessionStatusFunc(videoUrl){ (url) in
                self.finishedPicking(media: .video, url: url, error: nil)
            }
        } else {
            self.finishedPicking(media: .video, url: nil, error: nil)
        }
    }
    
}
    
fileprivate extension MediaPickerViewController {
    //MARK: Video Compressing technique
    func compressWithSessionStatusFunc(_ videoUrl: NSURL, completion : @escaping CompressedVideoCompletion) {
        let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".MOV")
        compressVideo(inputURL: videoUrl as URL, outputURL: compressedURL) { (exportSession) in
            guard let session = exportSession else {
                return
            }
            
            switch session.status {
            case .completed:
                guard let compressedData = NSData(contentsOf: compressedURL) else {
                    completion(nil)
                    return
                }
                
                print("File size after compression: \(Double(compressedData.length) / 1048576.0) mb")
                completion(compressedURL)
            default:
                completion(nil)
            }
        }
    }
    
    // Now compression is happening with medium quality, we can change when ever it is needed
    func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPreset1280x720) else {
            handler(nil)
            return
        }
        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mov
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously {
            handler(exportSession)
        }
    }
    
}

//MARK: - FILE IMPORT DELEGATE
extension MediaPickerViewController: UIDocumentMenuDelegate, UIDocumentPickerDelegate{
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    func documentMenuWasCancelled(_ documentMenu: UIDocumentMenuViewController) {
        self.cancelPicking()
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let imagesTypes = ["png", "jpg", "jpeg"]
        let audioTypes = ["mp3", "m4a","wav"]
        let videoTypes = ["mp4","mov","m4v"]
        
        if imagesTypes.contains(url.pathExtension) {
            self.finishedPicking(media: .image, url: url, error: nil)
        } else if audioTypes.contains(url.pathExtension) {
            self.finishedPicking(media: .audio, url: url, error: nil)
        } else if videoTypes.contains(url.pathExtension){
            self.compressWithSessionStatusFunc(url as NSURL){ (url) in
                self.finishedPicking(media: .video, url: url, error: nil)
            }
        } else {
            self.showAlert(title: "OOOpps", message: "File type not supported", hideAfter: 3.0)
        }
    }
    
    //    Method to handle cancel action.
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        self.cancelPicking()
    }
}

protocol MediaPickerControllerDelegate: NSObjectProtocol {
    func picker(_ controller: MediaPickerViewController, didFinishPickingMedia type: MediaType, url: URL?, error: Error?)
    
    func pickerDidCancel(_ controller: MediaPickerViewController)
}

enum MediaType: String {
    case video = "video/mp4"
    case image = "image"
    case audio = "audio/mp3"
}

enum SupportedMediaTypes: String {
    case video = "video/mp4"
    case image = "image"
    case audio = "audio/mp3"
    case all = "all"
}

typealias CompressedVideoCompletion = (_ url: URL?) -> Void

enum AttachmentType: String {
    case video, photoLibrary
}
