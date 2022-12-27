//
//  SetupTableViewExtension.swift
//  UIKitAndFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/27/22.
//

import Foundation
import UIKit

extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    
    // MARK: setupMessagesTableView()
    // setup constrains for messagesTableView
    func setupMessagesTableView() {
        messagesTableView = UITableView()
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: CustomCellReuseIdentifier.messagesCell.rawValue)
        messagesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messagesTableView)
        
        // Set Constraints
        messagesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messagesTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messagesTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        messagesTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    
    // MARK: Implement UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: CustomCellReuseIdentifier.messagesCell.rawValue, for: indexPath)
        
        let message = allMessages[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "#: \(indexPath.row + 1)\nTitle: \(message.title)"
        let imagesTitle = UIImage.SymbolConfiguration(textStyle: .title3)
        content.image = UIImage(systemName: "envelope.fill", withConfiguration: imagesTitle)
        content.secondaryText = "Body: \(message.body)\nDate: \(convertDate(date: message.messagesDate))"
        content.imageProperties.tintColor = .green
        cell.contentConfiguration = content
        
        return cell
        
    }

    
}
