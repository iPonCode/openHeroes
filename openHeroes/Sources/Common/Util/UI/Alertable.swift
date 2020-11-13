//  Alertable.swift
//  openHeroes
//
//  Created by Simón Aparicio on 12/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

protocol Alertable {
    var view: UIViewController? { get }
    func showAlert(msg: String, title: String)
}

extension Alertable {
    
    func showAlert(msg: String, title: String) {
        
        // If there was already a viewController presented dismiss it and present the new one
        if view?.presentedViewController != nil {
            view?.presentedViewController?.dismiss(animated: true) { presentAlert(msg: msg, title: title) }
        } else {
            presentAlert(msg: msg, title: title)
        }
        
    }
    
    private func presentAlert(msg: String, title: String) {
        let alertController = UIAlertController(title: title,
                                                message: msg,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        alertController.addAction(action)
        view?.present(alertController, animated: true, completion: nil)
    }
    
}
