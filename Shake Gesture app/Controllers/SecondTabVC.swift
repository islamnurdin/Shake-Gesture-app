//
//  SecondTabVC.swift
//  Shake Gesture app
//
//  Created by Name on 5/24/19.
//  Copyright © 2019 Name. All rights reserved.
//

import UIKit

class SecondTabVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Pull down to refresh feature
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        tableView.refreshControl = refresher
    }
    
    @objc func requestData() {
        
        tableView.reloadData()
        self.refresher.endRefreshing()
        
    }
}

//tableView
extension SecondTabVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SecondTabTVC
        
        let success = UserDefaults.standard.object(forKey: "successes")
        let attempt = UserDefaults.standard.object(forKey: "attempts")
        cell.successCount.text = "Success count: \(success ?? 0)"
        cell.attemptCount.text = "Attempt count: \(attempt ?? 0)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
}
