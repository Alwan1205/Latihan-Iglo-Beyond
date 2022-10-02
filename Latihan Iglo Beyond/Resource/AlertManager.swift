//
//  AlertManager.swift
//  Latihan Iglo Beyond
//
//  Created by Muhammad Alwan on 28/09/22.
//

import UIKit

class AlertManager {
    
    public func showAlert(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
    
}
