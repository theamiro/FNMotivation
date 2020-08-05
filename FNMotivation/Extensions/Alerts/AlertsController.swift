//
//  AlertsController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 24/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class AlertsController {
    static let shared = AlertsController.init()
    
    func generateAlert(withError error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindow.Level.alert + 1;
        window.makeKeyAndVisible()
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
