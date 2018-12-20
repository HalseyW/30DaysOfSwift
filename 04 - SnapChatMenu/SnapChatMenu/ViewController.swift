//
//  ViewController.swift
//  SnapChatMenu
//
//  Created by HalseyW-15 on 2018/12/20.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//
//知识点：
//1. xib中的File`s Owner设置其class；在xib中设置View Outlets，将File`s Owner和view连线，否则会报错。
//2.
//

import UIKit

class ViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {return true}
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftViewController = LeftViewController.init(nibName: "LeftView", bundle: nil)
        let rightViewController = RightViewController.init(nibName: "RightView", bundle: nil)
        let cameraViewController = CameraViewController.init(nibName: "CameraView", bundle: nil)
        
        self.addChild(leftViewController)
        self.scrollView.addSubview(leftViewController.view)
        leftViewController.didMove(toParent: self)
        
        self.addChild(cameraViewController)
        self.scrollView.addSubview(cameraViewController.view)
        cameraViewController.didMove(toParent: self)
        
        self.addChild(rightViewController)
        self.scrollView.addSubview(rightViewController.view)
        rightViewController.didMove(toParent: self)
        
        var cameraViewFrame = cameraViewController.view.frame
        cameraViewFrame.origin.x = self.view.frame.width
        cameraViewController.view.frame = cameraViewFrame
        
        var rightViewFrame = rightViewController.view.frame
        rightViewFrame.origin.x = 2 * self.view.frame.width
        rightViewController.view.frame = rightViewFrame
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: 0)
    }

}

