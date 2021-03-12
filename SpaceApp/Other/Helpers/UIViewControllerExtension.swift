//
//  UIViewControllerExtension.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit

extension UIViewController {
    func subscribeNetworkChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(connectionStatusChanged(_:)), name: .networkStatusUpdated, object: nil)
    }
    @objc private func connectionStatusChanged(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: NetworkStatus],
           let status = userInfo["NetworkStatus"] {
            if status == .connected {
                if let self = self as? GenericListView {
                    self.reloadData()
                }
            }
            self.showAlert(title: "Error Occured", text: status.networkStatusChangeAlertText)
        }
    }
    
    func showAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
