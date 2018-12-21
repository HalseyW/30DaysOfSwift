//
//  ViewController.swift
//  PullToRefresh
//
//  Created by HalseyW-15 on 2018/12/21.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//
//知识点：
//1. 通过attributedTitle设置refreshControl的提示文字。
//2. 新建UITableViewController并将其tableView直接添加当前controller。

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    var emojiData = [String]()
    
    var tableViewController = UITableViewController(style: .plain)
    let cellIdentifer = "NewCellIdentifer"
    
    var refreshControl = UIRefreshControl()
    var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiData = favoriteEmoji
        let emojiTableView = tableViewController.tableView
        
        emojiTableView?.backgroundColor = UIColor(displayP3Red: 0.092, green: 0.096, blue: 0.116, alpha: 1)
        emojiTableView?.dataSource = self
        emojiTableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        
        tableViewController.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        refreshControl.backgroundColor = UIColor(displayP3Red: 0.113, green: 0.113, blue: 0.145, alpha: 1)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Last updated on \(Date())", attributes: attributes)
        refreshControl.tintColor = UIColor.white
        
        title = "emoji"
        navBar.barStyle = .blackTranslucent
        
        emojiTableView?.rowHeight = UITableView.automaticDimension
        emojiTableView?.estimatedRowHeight = 90
        emojiTableView?.tableFooterView = UIView(frame: CGRect.zero)
        emojiTableView?.separatorStyle = .none
        
        view.addSubview(emojiTableView!)
        view.addSubview(navBar)
    }

    @objc func refresh() {
        emojiData = newFavoriteEmoji
        tableViewController.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        cell.textLabel?.text = emojiData[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 50)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
}

