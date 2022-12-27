//
//
// MainViewController.swift
//  UIKitAndFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/27/22.
//

import UIKit

class MainViewController: UIViewController {

    var messagesTableView: UITableView!
    var allMessages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "UIKit & Firebase"
        
        setupMessagesTableView()
        setupNotification()
        addBarButtonItem()
    }
    
    // Work with Date
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    func convertDate(date: Date) -> String {
        return itemFormatter.string(from: date)
    }


}

