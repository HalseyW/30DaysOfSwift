//
//  PhotoScrollViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/17.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIPageViewController {
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    var image: UIImage!
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        imageView = UIImageView(image: image)
        
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScale(forSize: view.bounds.size)
    }

    func updateMinZoomScale(forSize size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }

}

extension PhotoDetailViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
  
}
