//
//  LoginViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/9.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let button1 = UIButton()
    let button2 = UIButton()
    let screenWith = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green
        
        button1.setTitle("This is a button", for: .normal)
        button1.backgroundColor = .lightGray
        self.view.addSubview(button1)
        button1.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.center.equalToSuperview()
        }
        
        button2.setTitle("This is another button", for: .normal)
        button2.backgroundColor = .lightGray
        self.view.addSubview(button2)
        button2.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(button1.snp.bottom).offset(20)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        button1.alpha = 0
        button1.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview().offset(-screenWith + 30)
        }
        
        button2.alpha = 0
        button2.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview().offset(-screenWith + 30)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            self.button1.snp.updateConstraints { (make) in
                make.centerX.equalToSuperview()
            }
            self.button1.alpha = 1
            self.view.layoutIfNeeded()
        }.startAnimation()
        
        
         UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            self.button2.snp.updateConstraints { (make) in
                make.centerX.equalToSuperview()
            }
            self.button2.alpha = 1
            self.view.layoutIfNeeded()
        }.startAnimation(afterDelay: 0.1)
    }
    
}
