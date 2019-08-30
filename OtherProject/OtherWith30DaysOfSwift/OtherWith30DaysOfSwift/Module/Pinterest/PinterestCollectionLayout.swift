//
//  PinterestCollectionLayout.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/19.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

/// 瀑布流代理
@objc protocol PinterestCollectionLayoutDataSource : class {
    /// 指定item的高度
    func itemHeight(in layout: PinterestCollectionLayout, at indexPath: IndexPath) -> CGFloat
    
    /// 瀑布流一共有多少列，默认两列
    @objc optional func numberOfColumns(in layout : PinterestCollectionLayout) -> Int
}

class PinterestCollectionLayout: UICollectionViewFlowLayout {
    // MARK: 对外提供属性
    // 瀑布流数据源代理
    weak var dataSource: PinterestCollectionLayoutDataSource?
    // MARK: 私有属性
    // 布局属性数组
    private lazy var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    //每一列的高度累计
    private lazy var columnHeights: [CGFloat] = {
        let columnsCount = self.dataSource!.numberOfColumns?(in: self) ?? 2
        return Array(repeating: self.sectionInset.top, count: columnsCount)
    }()
    // 最高的高度
    private var maxHeight: CGFloat = 0
    //索引
    private var startIndex = 0
}

extension PinterestCollectionLayout {
    
    override func prepare() {
        super.prepare()
        //获取item的个数
        let itemCount = self.collectionView!.numberOfItems(inSection: 0)
        //获取列数
        let columnCount = self.dataSource?.numberOfColumns?(in: self) ?? 2
        //计算item的宽度（屏幕宽度铺满）
        let itemWidth = (collectionView!.bounds.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * CGFloat(columnCount - 1)) / CGFloat(columnCount)
        
        //计算所有item的属性
        for i in startIndex ..< itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            // 根据位置创建Attributes属性
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 获取item的高度
            guard let itemHeight = dataSource?.itemHeight(in: self, at: indexPath) else {
                fatalError("未设置数据源,未实现数据源方法")
            }
            
            //取出当前列所属的列索引
            let index = i % columnCount
            //获取当前列的总高度
            var columnHeight = columnHeights[index]
            //将当前列的高度在加载当前item的高度
            columnHeight = columnHeight + itemHeight + minimumLineSpacing
            //重新设置当前列的高度
            columnHeights[index] = columnHeight
            
            //设置item的属性
            attrs.frame = CGRect(x: self.sectionInset.left + (self.minimumInteritemSpacing + itemWidth) * CGFloat(index), y: columnHeight - itemHeight - self.minimumLineSpacing, width: itemWidth, height: itemHeight)
            
            attrsArray.append(attrs)
        }
        
        //记录最大值
        maxHeight = columnHeights.max()!
        //给startIndex重新赋值
        startIndex = itemCount
    }
}

extension PinterestCollectionLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxHeight + sectionInset.bottom - minimumLineSpacing)
    }
}
