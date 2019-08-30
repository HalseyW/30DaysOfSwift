//
//  FlickrViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/8/30.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class FlickrViewController: UIViewController {
    let flickrAPIKey = "99825c07cd88b7af4646117f230d7b13"
    let searchKeyword = "plane"

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    @objc func onClickRequestButton(_ sender: UIButton) {
        guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(flickrAPIKey)&text=\(searchKeyword)&per_page=20&format=json&nojsoncallback=1") else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print(result)
            } catch {
                print("response data json serialize error")
            }
        }
        task.resume()
    }

}

extension FlickrViewController {
    func initView() {
        self.view.backgroundColor = .white
        
        let button = UIButton()
        
        button.backgroundColor = .blue
        button.setTitle("发送请求", for: .normal)
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
        button.addTarget(self, action: #selector(onClickRequestButton(_:)), for: .touchUpInside)
    }
}
