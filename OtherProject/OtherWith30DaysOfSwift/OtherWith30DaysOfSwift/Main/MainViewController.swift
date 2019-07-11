//
//  MainViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/9.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let data = ["LoginAnimation", "AnimateTableViewCell", "EmojiSlotMachine", "FacebookMe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MainViewControllerCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewControllerCell", for: indexPath)
        let text = data[indexPath.row]
        cell.textLabel?.text = text
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.present(UINavigationController(rootViewController: LoginAnimationViewController()), animated: true, completion: nil)
        case 1:
            self.present(AnimatedTableViewController(), animated: true, completion: nil)
        case 2:
            self.present(EmojiSlotMachineViewController(), animated: true, completion: nil)
        case 3:
            self.present(UINavigationController(rootViewController: FacebookMeViewController()), animated: true, completion: nil)
        default:
            break
        }
    }

}