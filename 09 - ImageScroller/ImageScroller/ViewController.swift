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
//3. 使用 ScrollView 自带 delegate 完成缩放功能。
//
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTraillingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.isScrollEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //每次控制器更新其子视图时，更新最小缩放比例
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    /**
     计算scrollView的缩放比例，缩放比例为1表示内容以正常大小显示；缩放比例小于1表示容器内的内容缩小，缩放比例大于1表示放大容器内的内容。
     */
    func updateMinZoomScaleForSize(_ size: CGSize) {
        //要获得最小的缩放比例，首先计算所需的缩放比例，以便根据其宽度在scrollView中紧贴imageView
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        //选取宽度和高度比例中最小的那个,设置为minimumZoomScale
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 5.0
        scrollView.zoomScale = minScale
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    /**
     scrollview内容居中
     */
    func updateConstraintsForSize(_ size: CGSize) {
        //用视图高度减去imageView高度并再除以2，用作上下约束，使其垂直居中。
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        //用视图宽度减去imageView高度并再除以2，用作前后约束，使其水平居中。
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTraillingConstraint.constant = xOffset

        view.layoutIfNeeded()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //当手势动作发生时，scrollView告诉控制器要放大或缩小子视图imageView
        return imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == scrollView.minimumZoomScale {
            scrollView.isScrollEnabled = false
        } else {
            scrollView.isScrollEnabled = true
        }
    }

}
