//
//  PinterestViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/19.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class PinterestViewController: UIViewController {
    var cellCount = 30

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = PinterestCollectionLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.dataSource = self
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
    }

}

extension PinterestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == cellCount - 1 {
            cellCount += 30
            
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()) {
                DispatchQueue.main.sync {
                    collectionView.reloadData()
                }
            }
            
        }
    }
    
}

extension PinterestViewController: PinterestCollectionLayoutDataSource {
    func itemHeight(in layout: PinterestCollectionLayout, at indexPath: IndexPath) -> CGFloat {
        return CGFloat.random(in: 50 ... 200)
    }
    
    func numberOfColumns(in layout: PinterestCollectionLayout) -> Int {
        return 3
    }
}

extension UIColor{
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat.random(in: 0 ... 255), g: CGFloat.random(in: 0 ... 255), b: CGFloat.random(in: 0 ... 255))
    }
}
