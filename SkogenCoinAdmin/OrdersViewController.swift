//
//  ViewController.swift
//  SkogenCoinAdmin
//
//  Created by Dmitry Kuzin on 29/11/2018.
//  Copyright © 2018 SkogenCoin. All rights reserved.
//

import UIKit

let updateNotification = NSNotification.Name(rawValue: "ContentDidChanged")

class OrdersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items: [Order] = []
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(updateContent), for: .valueChanged)
        tableView.addSubview(refreshControl)
        configNavigationController()
        updateContent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateContent), name: updateNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configNavigationController() {
        navigationController?.setTitleColor(try! UIColor(rgba_throws: "#2C365D"))
        navigationController?.setTintColor(try! UIColor(rgba_throws: "#FF5E3A"))
        navigationController?.setBarTintColor(try! UIColor(rgba_throws: "#F2F2F0"))
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.hide = true
    }
    
    @objc func updateContent() {
        APIClient.shared.orders { (items) in
            self.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
}

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableCell", for: indexPath) as! OrderTableCell
        cell.order = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

class OrderTableCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var order: Order? {
        didSet {
            update()
        }
    }
    
    private func update() {
        guard let order = order else { return }
        numberLabel.text = "#" + order._id
        dateLabel.text = order.createdDate.dateString(format: "dd MMMM yyyy HH:mm")
        titleLabel.text = order.items.first?.item.meal.name
        volumeLabel.text = order.items.first?.item.volume
        typeLabel.text = order.items.first?.item.type
        priceLabel.text = "\(order.items.first?.item.price ?? 0) NOK"
    }
    
}

extension Date {
    
    func dateString(format: String = "dd.MM.yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
