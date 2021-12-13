//
//  DataManager.swift
//  Lola App
//
//  Created by Lola M on 12/12/21.
//


import Foundation
import SystemConfiguration
import UIKit

class DataManager {

    static var shared = DataManager()

    private init() {}
    //isReachable func: let us know about the connection
    // MARK: - Reachability
    public var isReachable: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
}



// MARK: - Show Generic Alert
//for showing alert
extension UIViewController {

    func showAlert(title: String?, message: String?, hideAfter time: Double) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            alert.dismiss(animated: true)
        }
    }
    
// to hide the people
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// to check valid email
extension String {
    var isEmail: Bool {
        if let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) {
            guard let result = dataDetector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) else { return false }
            guard let url = result.url else { return false }
            return url.scheme == "mailto"
        }
        return false
    }
}



extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

