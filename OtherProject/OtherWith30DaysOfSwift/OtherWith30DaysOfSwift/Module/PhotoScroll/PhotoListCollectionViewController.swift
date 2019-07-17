//
//  PhotoListCollectionViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/17.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
let screenWidth = UIScreen.main.bounds.width

class PhotoListCollectionViewController: UICollectionViewController {
    let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    let thumenailSize = CGSize(width: (screenWidth - 6) / 3, height: (screenWidth - 6) / 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.clearsSelectionOnViewWillAppear = false
        
        self.collectionView.backgroundColor = .white
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.itemSize = thumenailSize
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        let photo = UIImage(named: photos[indexPath.row])
        cell.imageView.image = photo?.thumb(ofSize: thumenailSize)
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PhotoPageViewController(transitionStyle: .scroll,
                                                 navigationOrientation: .horizontal,
                                                 options: [UIPageViewController.OptionsKey.interPageSpacing: 20])
        controller.currentIndex = indexPath.row
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

class PhotoCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    func thumb(ofSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let thumnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return thumnail!
    }
}
