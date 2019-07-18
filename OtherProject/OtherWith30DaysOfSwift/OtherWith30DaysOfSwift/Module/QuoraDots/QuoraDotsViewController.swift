//
//  QuoraDotsViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/18.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class QuoraDotsViewController: UIPageViewController {
    let ivDot1 = UIImageView(image: UIImage(named: "quora_dot"))
    let ivDot2 = UIImageView(image: UIImage(named: "quora_dot"))
    let ivDot3 = UIImageView(image: UIImage(named: "quora_dot"))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let ivLogo = UIImageView(image: UIImage(named: "quora_logo"))
        self.view.addSubview(ivLogo)
        ivLogo.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-(screenHeight / 4))
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(ivDot2)
        ivDot2.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(ivLogo.snp.bottom).offset(20)
        }
        
        self.view.addSubview(ivDot1)
        ivDot1.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.top.equalTo(ivDot2.snp.top)
            make.right.equalTo(ivDot2.snp.left).offset(-20)
        }
        
        self.view.addSubview(ivDot3)
        ivDot3.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.top.equalTo(ivDot2.snp.top)
            make.left.equalTo(ivDot2.snp.right).offset(20)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }
    
    func startAnimation() {
        self.ivDot1.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        self.ivDot2.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        self.ivDot3.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            self.ivDot1.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            self.ivDot2.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            self.ivDot3.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
