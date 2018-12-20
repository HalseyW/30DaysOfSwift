//
//  ViewController.swift
//  CustomFont
//
//  Created by HalseyW-15 on 2018/12/19.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//
//知识点：
//1. 在 Info.plist 中添加 「Fonts provided by application」，并在其下添加字体文件名
//2. 在 TARGETS -> 项目 -> Build Phases -> Copy Bundle Resources 下添加字体文件
//3. 通过 index = 0, index = (index + 1) % n 来不断轮询数组b下标

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var data = ["30 Days Swift", "这些字体特别适合打「奋斗」和「理想」", "谢谢「造字工房」，本案例不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体", "呵呵，再见🤗 See you next Project", "微博 @Wushhhhhh",
                "测试测试测试测试测试测试",
                "123",
                "Wushhhhhh",
                "@@@@@@"]
    var fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular", "Zapfino", "Gaspar Regular"]
    
    @IBOutlet weak var btnChangeFont: UIButton!
    @IBOutlet weak var tbFont: UITableView!
    
    var fontRowIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbFont.delegate = self
        tbFont.dataSource = self
        btnChangeFont.layer.cornerRadius = 50
    }
    
    @IBAction func onClickChangeFontButton(_ sender: UIButton) {
        fontRowIndex = (fontRowIndex + 1) % 5
        tbFont.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbFont.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath)
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font  = UIFont(name: fontNames[fontRowIndex], size: 16)
        
        return cell
    }
}

