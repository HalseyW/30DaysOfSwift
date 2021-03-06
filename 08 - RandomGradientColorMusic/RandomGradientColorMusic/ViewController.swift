//
//  ViewController.swift
//  RandomGradientColorMusic
//
//  Created by HalseyW-15 on 2018/12/21.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//

import UIKit
import  AVFoundation

class ViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {return true}
    var audioPlayer = AVAudioPlayer()
    let gradientLayer = CAGradientLayer()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onClickPlayButton(_ sender: UIButton) {
        guard let musicPath = Bundle.main.path(forResource: "Ecstasy", ofType: "mp3") else {
            return
        }
        let musicURL = URL(fileURLWithPath: musicPath)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            try audioPlayer = AVAudioPlayer(contentsOf: musicURL)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(randomColor), userInfo: nil, repeats: true)
        }
        
        gradientLayer.frame = view.bounds
        let color1 = UIColor(white: 0.5, alpha: 0.2).cgColor as CGColor
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).cgColor as CGColor
        let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor as CGColor
        let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).cgColor as CGColor
        let color5 = UIColor(white: 0.4, alpha: 0.2).cgColor as CGColor
        
        gradientLayer.colors = [color1, color2, color3, color4, color5]
        gradientLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        view.layer.addSublayer(gradientLayer)
    }
    
    @objc func randomColor() {
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
}

