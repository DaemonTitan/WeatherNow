//
//  AlertManager.swift
//  WeatherNow
//
//

import Foundation
import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: ViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "Setting", style: .cancel, handler: { action in
            let alert = Alert()
            alert.openSettings()
        })
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
        
        alert.addAction(settingAction)
        alert.addAction(dismissAction)
        vc.present(alert, animated: true)
    }
    
    private static func showErrorAlert(on vc: ViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
        
        alert.addAction(dismissAction)
        vc.present(alert, animated: true)
    }
    
    func openSettings() {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// Location data is restricted
    static func showLocationRestrictedAlert(on vc: UIViewController) {
        showBasicAlert(on: vc as! ViewController, with: "App does not have authorise to access your location", message: "Please change settings to allow location access.")
    }
    /// Location data is denied
    static func showLocationDeniedAlert(on vc: UIViewController) {
        showBasicAlert(on: vc as! ViewController, with: "Location service has been denied", message: "Please go to location settings to enable location service.")
    }
    
    static func showLocationErrorAlert(on vc: UIViewController) {
        showErrorAlert(on: vc as! ViewController, with: "Location access error", message: "App can not access location servcie, because there is an error.")
    }
}
