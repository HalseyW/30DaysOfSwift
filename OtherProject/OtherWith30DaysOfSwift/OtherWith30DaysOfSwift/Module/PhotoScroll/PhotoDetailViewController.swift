//
//  PhotoScrollViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/17.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIPageViewController {
    let imageView = UIImageView()
    let scrollView = UIScrollView()
    var image: UIImage!
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
           make.top.bottom.left.right.equalToSuperview()
        }
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScale(forSize: view.bounds.size)
    }
    
    fileprivate func updateConstraints(forSize size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
//        imageViewTopConstraint.constant = yOffset
//        imageViewBottomConstraint.constant = yOffset
        
        imageView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(yOffset)
            make.bottom.equalToSuperview().offset(-yOffset)
        }

        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
//        imageViewLeadingConstraint.constant = xOffset
//        imageViewTrailingConstraint.constant = xOffset

        imageView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(xOffset)
            make.right.equalToSuperview().offset(-xOffset)
        }
        
        self.view.layoutIfNeeded()
    }
    
    fileprivate func updateMinZoomScale(forSize size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        
        /// set up the init zoom scale
        scrollView.zoomScale = minScale
    }

}

extension PhotoDetailViewController: UIScrollViewDelegate {
    
    /// Tell the delegate that the imageView will be made smaller or bigger.
    ///
    /// - Parameter scrollView: scrollView delegate to current view controller
    /// - Returns: the view is zoomed in and out
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    /// Called every time zoom in or out the scroll View
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraints(forSize: view.bounds.size)
    }
}


