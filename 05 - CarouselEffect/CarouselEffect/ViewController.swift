//
//  ViewController.swift
//  CarouselEffect
//
//  Created by HalseyW-15 on 2018/12/20.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//
//知识点：
//1. 通过添加UIVisualEffectView实现blur效果
//2. UICollectionView通过Min Spacing和Section Insets来调整Cell之间的间距
//

import UIKit

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    @IBOutlet weak var collectionView: UICollectionView!
    var interests = Interest.createInterests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath) as! InterestCollectionViewCell
        cell.interest = self.interests[indexPath.item]
        return cell
    }
}

