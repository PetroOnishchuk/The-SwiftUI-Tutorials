//
//  MainViewController.swift
//  UIKitandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/8/22.
//

import UIKit

class MainViewController: UIViewController {
    var messagesTableView: UITableView!
    var allMessages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UIKit & AWS SNS"
        setupMessagesTableView()
        setupNotifications()
        addBarButtonItem()
    }
    

     //MARK: AddBarButtonItem()
    func addBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cleanMessagesList))
    }
    @objc func cleanMessagesList() {
        DispatchQueue.main.async { [weak self] in
            self?.allMessages = []
            self?.messagesTableView.reloadData()
        }
    }
    
    //Work with Date
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    

}
