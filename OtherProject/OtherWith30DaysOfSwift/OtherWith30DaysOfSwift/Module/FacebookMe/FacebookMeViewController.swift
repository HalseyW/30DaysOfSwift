//
//  FacebookMeViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/11.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class FacebookMeViewController: UIViewController {
    /// 设置 style 是关键，grouped 代表分组
    let tableView = UITableView(frame: .zero, style: .grouped)
    /// data source
    var user: User { return User(name: "Wushhhh", avatar: "bayMax", education: "UCLA") }
    var dataSource: [[String: Any]] { return TableKeys.getDataSource(from: user) }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        
        self.title = "Facebook"
        self.navigationController?.navigationBar.barTintColor = Specs.color.tint
        
        tableView.register(FacebookMeTableViewCell.self, forCellReuseIdentifier: FacebookMeTableViewCell.reuseIdentifier)
        tableView.indicatorStyle = .white
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }
    
    /// 某个 section 里面 的 rows
    func rows(in section: Int) -> [Any] {
        return dataSource[section][TableKeys.rows] as! [Any]
    }
    
    /// 某个 section 的title
    func title(for section: Int) -> String? {
        return dataSource[section][TableKeys.sections] as? String
    }
    
    /// 一个 cell 的 model
    typealias modelForCell = [String: String]
    func cellModel(for indexPath: IndexPath) -> modelForCell {
        return rows(in: indexPath.section)[indexPath.row] as! modelForCell
    }

}

extension FacebookMeViewController: UITableViewDataSource {
    /// section 的数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    /// 每个 section 的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows(in: section).count
    }
    
    /// section 的 title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return title(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModel(for: indexPath)
        var cell = UITableViewCell()
        
        guard let title = model[TableKeys.title] else { return cell }
        
        if title == user.name {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: FacebookMeTableViewCell.reuseIdentifier, for: indexPath)
        }
        
        cell.textLabel?.text = title
        
        if let imageName = model[TableKeys.imageName] {
            cell.imageView?.image = UIImage(named: imageName)
        } else if title != TableKeys.logout {
            cell.imageView?.image = UIImage(named: Specs.imageName.placeholder)
        }
        
        if title == user.name {
            cell.detailTextLabel?.text = model[TableKeys.subtitle]
        }
        
        return cell
    }
    
}

extension FacebookMeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = cellModel(for: indexPath)
        
        guard let title = model[TableKeys.title] else {
            return 0.0
        }
        
        if title == user.name {
            return 64.0
        } else {
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let model = cellModel(for: indexPath)

        guard let title = model[TableKeys.title] else {
            return
        }
        
        if title == TableKeys.seeMore || title == TableKeys.addFavorite {
            cell.textLabel?.textColor = Specs.color.tint
            cell.accessoryType = .none
        } else if title == TableKeys.logout {
            cell.textLabel?.snp.updateConstraints({ (make) in
                make.center.equalToSuperview()
            })
            cell.textLabel?.textColor = Specs.color.red
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
    }
}

struct TableKeys {
    static func getDataSource(from user: User) -> [[String: Any]] {
        return [
            [TableKeys.rows: [
                        [TableKeys.imageName: user.avatar, TableKeys.title: user.name, TableKeys.subtitle: "View your profile"]
                    ]
            ],
            [TableKeys.rows: [
                        [TableKeys.imageName: Specs.imageName.friends, TableKeys.title: "Friends"],
                        [TableKeys.imageName: Specs.imageName.events, TableKeys.title: "Events"],
                        [TableKeys.imageName: Specs.imageName.groups, TableKeys.title: "Groups"],
                        [TableKeys.imageName: Specs.imageName.education, TableKeys.title: user.education],
                        [TableKeys.imageName: Specs.imageName.townHall, TableKeys.title: "Town Hall"],
                        [TableKeys.imageName: Specs.imageName.instantGames, TableKeys.title: "Instant Games"],
                        [TableKeys.title: TableKeys.seeMore],
                    ]
            ],
            [TableKeys.sections: "FAVORITE",
             TableKeys.rows: [
                        [TableKeys.title: TableKeys.addFavorite]
                    ]
            ],
            [TableKeys.rows: [
                        [TableKeys.imageName: Specs.imageName.settings, TableKeys.title: "Settings"],
                        [TableKeys.imageName: Specs.imageName.privacyShortcuts, TableKeys.title: "Privacy Shortcuts"],
                        [TableKeys.imageName: Specs.imageName.helpSupport, TableKeys.title: "Help and Support"]
                    ]
            ],
            [TableKeys.rows: [
                        [TableKeys.title: TableKeys.logout]
                    ]
            ]
        ]
    }
}

extension TableKeys {
    static let sections = "section"
    static let rows = "rows"
    
    static let title = "title"
    static let imageName = "imageName"
    static let subtitle = "subtitle"
    
    static let seeMore = "See More..."
    static let addFavorite = "Add Favorite..."
    static let logout = "Log Out"
}

struct User {
    var name: String
    var avatar: String
    var education: String
    
    init(name: String, avatar: String = "", education: String) {
        self.name = name
        self.avatar = avatar
        self.education = education
    }
}

public struct Specs {
    public struct Color {
        public let tint = UIColor(hex: 0x3b5998)
        public let red = UIColor.red
        public let white = UIColor.white
        public let black = UIColor.black
        public let gray = UIColor.lightGray
    }
    
    public struct FontSize {
        public let tiny: CGFloat = 10
        public let small: CGFloat = 12
        public let regular: CGFloat = 14
        public let large: CGFloat = 16
    }
    
    public struct Font {
        private static let regularName = "Helvetica Neue"
        private static let boldName = "Helvetica Neue Bold"
        public let tiny = UIFont(name: regularName, size: Specs.fontSize.tiny)
        public let small = UIFont(name: regularName, size: Specs.fontSize.small)
        public let regular = UIFont(name: regularName, size: Specs.fontSize.regular)
        public let large = UIFont(name: regularName, size: Specs.fontSize.large)
        public let smallBold = UIFont(name: boldName, size: Specs.fontSize.small)
        public let regularBold = UIFont(name: boldName, size: Specs.fontSize.regular)
        public let largeBold = UIFont(name: boldName, size: Specs.fontSize.large)
    }
    
    public struct ImageName {
        public let friends = "fb_friends"
        public let events = "fb_events"
        public let groups = "fb_groups"
        public let education = "fb_education"
        public let townHall = "fb_town_hall"
        public let instantGames = "fb_games"
        public let settings = "fb_settings"
        public let privacyShortcuts = "fb_privacy_shortcuts"
        public let helpSupport = "fb_help_and_support"
        public let placeholder = "fb_placeholder"
    }
    
    public static var color: Color {
        return Color()
    }
    
    public static var fontSize: FontSize {
        return FontSize()
    }
    
    public static var font: Font {
        return Font()
    }
    
    public static var imageName: ImageName {
        return ImageName()
    }
}

public extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
    
    convenience init(hex: Int) {
        self.init(r: (hex & 0xff0000) >> 16, g: (hex & 0xff00) >> 8, b: (hex & 0xff), a: 1)
    }
}

class FacebookMeTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FacebookMeTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Specs.color.white
        textLabel?.textColor = Specs.color.black
        textLabel?.font = Specs.font.large
        
        detailTextLabel?.font = Specs.font.small
        detailTextLabel?.textColor = Specs.color.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
