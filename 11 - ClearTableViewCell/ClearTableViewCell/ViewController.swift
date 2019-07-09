//
//  ViewController.swift
//  ClearTableViewCell
//
//  Created by HalseyW-15 on 2019/1/17.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//
//知识点：
// 1. 通过 UITableViewDelegate 中的 willDisplay 方法来单独设置 cell 的背景色，会覆盖在 cellForRowAt 方法中的设置。

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.textLabel?.text = "你有事吗"
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorforIndex(index: indexPath.row)
    }
    
    func colorforIndex(index: Int) -> UIColor {
        let itemCount = 30 - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: color, blue: 0.0, alpha: 1.0)
    }
}

