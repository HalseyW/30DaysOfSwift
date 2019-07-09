//
//  MainViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/9.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    let data = ["12 - LoginAnimation", "13 - AnimateTableViewCell"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewControllerCell", for: indexPath)
        let text = data[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.present(UINavigationController(rootViewController: LoginAnimationViewController()), animated: true, completion: nil)
        case 1:
            self.present(AnimatedTableViewController(), animated: true, completion: nil)
        default:
            break
        }
    }

}
