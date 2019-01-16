//
//  ViewController.swift
//  ImageScroller
//
//  Created by HalseyW-15 on 2019/1/14.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//
//知识点：
//1. UIView 的 autoresizingMask 属性描述的是当 superview 的 bounds 改变时自身应该怎样变化。
//2. UIView 的 frame 属性描述的是 view 在 superview 坐标系统下的位置和尺寸；bounds 属性描述的是在自己坐标系下的位置和尺寸。
//
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTraillingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTraillingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}

