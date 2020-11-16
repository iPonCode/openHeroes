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
        
        // If there was already an AlertController presented, dismiss it and present the new one:
        //      by example: Two Errors showns consecutively
        guard let isAlert = view?.presentedViewController?.isKind(of: UIAlertController.self), isAlert else {
            presentAlert(msg: msg, title: title)
            return
        }
        view?.presentedViewController?.dismiss(animated: true) { presentAlert(msg: msg, title: title) }
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
