//
//  AnimatedTableViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/9.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class AnimatedTableViewController: UITableViewController {
    let data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AnimatedTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.height
        
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            UIViewPropertyAnimator(duration: 1, dampingRatio: 1) {
                cell.transform = CGAffineTransform.identity
            }.startAnimation(afterDelay: 0.05 * Double(index))
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimatedTableViewCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

}
