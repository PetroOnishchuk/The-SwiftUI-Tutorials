//
//  SetupTableViewExtension.swift
//  UIKitandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/8/22.
//
 
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: setupMessageTableView()
    //setup constraints for messageTableView
    func setupMessagesTableView() {
        messagesTableView = UITableView()
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "messageCell")
        messagesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messagesTableView)
        messagesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messagesTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messagesTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        messagesTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    
    //MARK: Implemented  UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMessages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        let message = allMessages[indexPath.row]
        
        
        var content = cell.defaultContentConfiguration()
        content.text = message.title
        
        let largeTitle = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        content.image = UIImage(systemName: "envelope.fill", withConfiguration: largeTitle)
        content.secondaryText = "Info: \(message.description).\nSenderID: \(convertDate(date: message.massageDate))"
        content.imageProperties.tintColor = .red
        cell.contentConfiguration = content
        
        return cell
    }
}
