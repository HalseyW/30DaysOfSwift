//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by HalseyW-15 on 2018/12/19.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//
//知识点：
//1. 通过 AVPlayerViewController 和 AVPlayer 直接调用系统播放器播放视频
//2. 自定义 Cell，从 sb 拉取控件并调用
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var tbVideo: UITableView!
    var playViewController = AVPlayerViewController()
    var player = AVPlayer()
    
    var data = [
        Video(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        Video(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        Video(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
        Video(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
        Video(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
        Video(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbVideo.delegate = self
        tbVideo.dataSource = self
    }
    
    @IBAction func onClickPlayButton(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        playViewController.player = player
        self.present(playViewController, animated: true) {
            self.playViewController.player?.play()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbVideo.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
        let video = data[indexPath.row]
        
        cell.ivVideoScreenShot.image = UIImage(named: video.image)
        cell.labelVideoTitle.text = video.title
        cell.labelVideoSource.text = video.source
        
        return cell
    }
}
