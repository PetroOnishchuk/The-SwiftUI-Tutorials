//
//  BarButtonExtension.swift
//  UIKitAndFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/27/22.
//

import Foundation
import UIKit

extension MainViewController {
    
    //MARK: addBarButtonItem()
    func addBarButtonItem() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cleanMessagesList))
        ]
        // Change foreground color in rightBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    @objc func cleanMessagesList() {
        DispatchQueue.main.async {
            [weak self] in
            self?.allMessages = []
            self?.messagesTableView.reloadData()
        }
    }
}
