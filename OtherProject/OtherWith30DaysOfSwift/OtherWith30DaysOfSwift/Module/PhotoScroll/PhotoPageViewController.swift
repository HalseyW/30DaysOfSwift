//
//  PhotoPageViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/17.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class PhotoPageViewController: UIPageViewController {
    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var currentIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        self.dataSource = self

        let controller = getPhotoDetailController(by: currentIndex ?? 0)
        setViewControllers([controller], direction: .forward, animated: false, completion: nil)
    }
    
    func getPhotoDetailController(by index: Int) -> PhotoDetailViewController {
        let controller = PhotoDetailViewController()
        controller.index = index
        controller.image = UIImage(named: photos[index])
        return controller
    }
    
}

extension PhotoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let controller = viewController as? PhotoDetailViewController, controller.index - 1 >= 0 {
            return getPhotoDetailController(by: controller.index - 1)
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let controller = viewController as? PhotoDetailViewController, controller.index + 1 < photos.count {
            return getPhotoDetailController(by: controller.index + 1)
        }
        return nil
    }
    
    //实现这个方法会在下方显示圆形的数量指示器，不实现则会隐藏
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
    
}
