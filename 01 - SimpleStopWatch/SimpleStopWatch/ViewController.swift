//
//  ViewController.swift
//  SimpleStopWatch
//
//  Created by HalseyW-15 on 2018/12/19.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//
//知识点：
//1. 亮色状态栏
//2. 格式化Double
//3. UILabel内容动态变化时通过指定字体和大小来固定位置

import UIKit

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var labelTime: UILabel!
    
    var time = 0.0
    var timer = Timer()
    var isCounting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTime.text = String(time)
    }
    
    @IBAction func onClickPlayButton(_ sender: UIButton) {
        btnPlay.isEnabled = false
        btnPause.isEnabled = true
        isCounting = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func onClickPauseButton(_ sender: UIButton) {
        btnPlay.isEnabled = true
        btnPause.isEnabled = false
        isCounting = false
        timer.invalidate()
    }
    
    @IBAction func onClickResetButton(_ sender: UIButton) {
        btnPlay.isEnabled = true
        btnPause.isEnabled = false
        isCounting = false
        time = 0.0
        labelTime.text = String(time)
        timer.invalidate()
    }
    
    @objc func updateTime() {
        time = time + 0.1
        labelTime.text = String(format: "%.1f", time)
    }
}
