//
//  NewsTableViewCell.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/16.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "NewsTableViewCell"
    let labelTitle = UILabel()
    let labelDate = UILabel()
    let labelContent = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .lightGray
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15))
        }
        
        labelTitle.textColor = .black
        labelTitle.numberOfLines = 4
        labelTitle.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        view.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(10)
        }
        
        labelDate.textColor = .gray
        labelDate.numberOfLines = 1
        labelDate.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(labelDate)
        labelDate.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(labelTitle.snp.bottom).offset(2)
        }
        
        labelContent.textColor = .darkGray
        labelContent.numberOfLines = 2
        view.addSubview(labelContent)
        labelContent.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(labelDate.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
